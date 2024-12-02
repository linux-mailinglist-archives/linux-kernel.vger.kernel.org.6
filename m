Return-Path: <linux-kernel+bounces-428052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F6D9E0BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA796B3D0BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC87125B9;
	Mon,  2 Dec 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DccwYcLe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00876757EA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159295; cv=none; b=ETl8yC7+RwohTskjyYqrFPy6ApomzUqzIoCBNZ9nxHWlLrym+HQhWfzg+2728uA3nYFMB0m4GZHOhtvjTQcfw3SGTZ1Wx5sLZS0wfBlh6F5/+lN7r4PcNoZhXw+i9W1sTWyHj3ZNAHwx0dy3AQdfxf0Wx0/Vp2din5AjQDIH1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159295; c=relaxed/simple;
	bh=VwopOxdeKmb0fYdd9RFY267KXhqAS4dKma782XlxzRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TT3V1SKftK1dV3tBi2TujEaLFoJYEgnyjSj5mrxBoWOECQSJBLpCIiynZKVcQ+iVTrcY7S+rRxpMm3uZcYtUQ3cpOwrxdc2MtC/QAmHQ607gLLJFRdJmAw0X3ZSXPOp0XmdFxlx+XPjpPV4J2gh4lDOy6+m6jLWjDTAHzCjr9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DccwYcLe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159293; x=1764695293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VwopOxdeKmb0fYdd9RFY267KXhqAS4dKma782XlxzRY=;
  b=DccwYcLeq70FaRZGkRafmsz/2EF+r5Es3xHiyXcBE9J2JrCts9OZ4ij2
   Gp61BTJE8oGyWC88SY+1RS+XCGtV8XDF9S93fTKADE9hpv0SoIOYFO9JD
   MCsJltAGXUH0vLiWU7RP5mGmTkNP6Ic1oKvOr/hS4hPC1UehRRnV73piA
   wyUqfTXEOfo366YMmI1YQDp+9ZArllwbTasJKRiTyxg4xdydGKiu/4DPK
   RTPDKDlIHwoDwD6IkiP5jSqlmGhPoIBbfx5YT/rbCYvdQp+6Fnp7I+W1G
   oabz90Uti9PhvTaY0aXwy7ePfAv7ChEQZaOjYIKESj8M7896BSWJHEyWq
   A==;
X-CSE-ConnectionGUID: smamDbhWRwGl2XmaGwUI+w==
X-CSE-MsgGUID: hZAX56GFTWW4n/zF1H6hag==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36198882"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="36198882"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:08:13 -0800
X-CSE-ConnectionGUID: 024OYCbZRa6cyah2dXajIg==
X-CSE-MsgGUID: TaBN9DNaRyWpuksdiI/Mfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="116431158"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Dec 2024 09:08:10 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI9tk-0002e4-2w;
	Mon, 02 Dec 2024 17:07:55 +0000
Date: Tue, 3 Dec 2024 01:07:10 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: fs/nfsd/nfs4state.c:7881:29: error: variable 'sb' set but not used
Message-ID: <202412030038.Fh8VTQwJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
commit: 7e64c5bc497cf17872b38003307f320e8f077880 NLM/NFSD: Fix lock notifications for async-capable filesystems
date:   9 weeks ago
config: x86_64-rhel-9.4-nofixup (https://download.01.org/0day-ci/archive/20241203/202412030038.Fh8VTQwJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030038.Fh8VTQwJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030038.Fh8VTQwJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfsd/nfs4state.c: In function 'nfsd4_lock':
>> fs/nfsd/nfs4state.c:7881:29: error: variable 'sb' set but not used [-Werror=unused-but-set-variable]
    7881 |         struct super_block *sb;
         |                             ^~
   cc1: all warnings being treated as errors


vim +/sb +7881 fs/nfsd/nfs4state.c

64a284d07c7d842 J. Bruce Fields      2011-10-20  7863  
^1da177e4c3f415 Linus Torvalds       2005-04-16  7864  /*
^1da177e4c3f415 Linus Torvalds       2005-04-16  7865   *  LOCK operation 
^1da177e4c3f415 Linus Torvalds       2005-04-16  7866   */
b37ad28bcaa7c48 Al Viro              2006-10-19  7867  __be32
ca3643171bc6e08 J.Bruce Fields       2006-12-13  7868  nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
eb69853da945928 Christoph Hellwig    2017-05-08  7869  	   union nfsd4_op_u *u)
^1da177e4c3f415 Linus Torvalds       2005-04-16  7870  {
eb69853da945928 Christoph Hellwig    2017-05-08  7871  	struct nfsd4_lock *lock = &u->lock;
fe0750e5c43189a J. Bruce Fields      2011-07-30  7872  	struct nfs4_openowner *open_sop = NULL;
fe0750e5c43189a J. Bruce Fields      2011-07-30  7873  	struct nfs4_lockowner *lock_sop = NULL;
3d0fabd5a48fbf6 Trond Myklebust      2014-07-29  7874  	struct nfs4_ol_stateid *lock_stp = NULL;
0667b1e9d8a7c0a Trond Myklebust      2014-07-29  7875  	struct nfs4_ol_stateid *open_stp = NULL;
7214e8600eee146 Jeff Layton          2014-07-10  7876  	struct nfs4_file *fp;
eb82dd393744107 Jeff Layton          2019-08-18  7877  	struct nfsd_file *nf = NULL;
76d348fadff52e8 Jeff Layton          2016-09-16  7878  	struct nfsd4_blocked_lock *nbl = NULL;
21179d81f1de37c Jeff Layton          2012-08-21  7879  	struct file_lock *file_lock = NULL;
21179d81f1de37c Jeff Layton          2012-08-21  7880  	struct file_lock *conflock = NULL;
2dd10de8e6bcbac Alexander Aring      2023-09-12 @7881  	struct super_block *sb;
b37ad28bcaa7c48 Al Viro              2006-10-19  7882  	__be32 status = 0;
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7883  	int lkflg;
b8dd7b9ab194d9a Al Viro              2006-10-19  7884  	int err;
5db1c03feb00a72 Jeff Layton          2014-07-29  7885  	bool new = false;
60f3154d196b5b1 Jeff Layton          2024-01-31  7886  	unsigned char type;
60f3154d196b5b1 Jeff Layton          2024-01-31  7887  	unsigned int flags = FL_POSIX;
3320fef19b542b8 Stanislav Kinsbursky 2012-11-14  7888  	struct net *net = SVC_NET(rqstp);
3320fef19b542b8 Stanislav Kinsbursky 2012-11-14  7889  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
^1da177e4c3f415 Linus Torvalds       2005-04-16  7890  
^1da177e4c3f415 Linus Torvalds       2005-04-16  7891  	dprintk("NFSD: nfsd4_lock: start=%Ld length=%Ld\n",
^1da177e4c3f415 Linus Torvalds       2005-04-16  7892  		(long long) lock->lk_offset,
^1da177e4c3f415 Linus Torvalds       2005-04-16  7893  		(long long) lock->lk_length);
^1da177e4c3f415 Linus Torvalds       2005-04-16  7894  
^1da177e4c3f415 Linus Torvalds       2005-04-16  7895  	if (check_lock_length(lock->lk_offset, lock->lk_length))
^1da177e4c3f415 Linus Torvalds       2005-04-16  7896  		 return nfserr_inval;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7897  
ca3643171bc6e08 J.Bruce Fields       2006-12-13  7898  	if ((status = fh_verify(rqstp, &cstate->current_fh,
8837abcab3d1660 Miklos Szeredi       2008-06-16  7899  				S_IFREG, NFSD_MAY_LOCK))) {
a6f6ef2f1d73291 Andy Adamson         2006-01-18  7900  		dprintk("NFSD: nfsd4_lock: permission denied!\n");
a6f6ef2f1d73291 Andy Adamson         2006-01-18  7901  		return status;
a6f6ef2f1d73291 Andy Adamson         2006-01-18  7902  	}
2dd10de8e6bcbac Alexander Aring      2023-09-12  7903  	sb = cstate->current_fh.fh_dentry->d_sb;
a6f6ef2f1d73291 Andy Adamson         2006-01-18  7904  
^1da177e4c3f415 Linus Torvalds       2005-04-16  7905  	if (lock->lk_is_new) {
684e563858018d2 J. Bruce Fields      2011-11-04  7906  		if (nfsd4_has_session(cstate))
684e563858018d2 J. Bruce Fields      2011-11-04  7907  			/* See rfc 5661 18.10.3: given clientid is ignored: */
76f6c9e176dda6e Kinglong Mee         2015-07-13  7908  			memcpy(&lock->lk_new_clientid,
ec59659b4972ec2 J. Bruce Fields      2021-01-21  7909  				&cstate->clp->cl_clientid,
684e563858018d2 J. Bruce Fields      2011-11-04  7910  				sizeof(clientid_t));
684e563858018d2 J. Bruce Fields      2011-11-04  7911  
^1da177e4c3f415 Linus Torvalds       2005-04-16  7912  		/* validate and update open stateid and open seqid */
c0a5d93efbbb791 J. Bruce Fields      2011-09-06  7913  		status = nfs4_preprocess_confirmed_seqid_op(cstate,
^1da177e4c3f415 Linus Torvalds       2005-04-16  7914  				        lock->lk_new_open_seqid,
^1da177e4c3f415 Linus Torvalds       2005-04-16  7915  		                        &lock->lk_new_open_stateid,
3320fef19b542b8 Stanislav Kinsbursky 2012-11-14  7916  					&open_stp, nn);
375151773125f56 NeilBrown            2005-07-07  7917  		if (status)
^1da177e4c3f415 Linus Torvalds       2005-04-16  7918  			goto out;
feb9dad52092800 Oleg Drokin          2016-06-14  7919  		mutex_unlock(&open_stp->st_mutex);
fe0750e5c43189a J. Bruce Fields      2011-07-30  7920  		open_sop = openowner(open_stp->st_stateowner);
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7921  		status = nfserr_bad_stateid;
684e563858018d2 J. Bruce Fields      2011-11-04  7922  		if (!same_clid(&open_sop->oo_owner.so_client->cl_clientid,
76f6c9e176dda6e Kinglong Mee         2015-07-13  7923  						&lock->lk_new_clientid))
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7924  			goto out;
64a284d07c7d842 J. Bruce Fields      2011-10-20  7925  		status = lookup_or_create_lock_state(cstate, open_stp, lock,
5db1c03feb00a72 Jeff Layton          2014-07-29  7926  							&lock_stp, &new);
3d0fabd5a48fbf6 Trond Myklebust      2014-07-29  7927  	} else {
dd453dfd70538ca Benny Halevy         2009-04-03  7928  		status = nfs4_preprocess_seqid_op(cstate,
^1da177e4c3f415 Linus Torvalds       2005-04-16  7929  						  lock->lk_old_lock_seqid,
^1da177e4c3f415 Linus Torvalds       2005-04-16  7930  						  &lock->lk_old_lock_stateid,
3f29cc82a84c23c NeilBrown            2024-01-30  7931  						  SC_TYPE_LOCK, 0, &lock_stp,
3f29cc82a84c23c NeilBrown            2024-01-30  7932  						  nn);
3d0fabd5a48fbf6 Trond Myklebust      2014-07-29  7933  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  7934  	if (status)
^1da177e4c3f415 Linus Torvalds       2005-04-16  7935  		goto out;
fe0750e5c43189a J. Bruce Fields      2011-07-30  7936  	lock_sop = lockowner(lock_stp->st_stateowner);
^1da177e4c3f415 Linus Torvalds       2005-04-16  7937  
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7938  	lkflg = setlkflg(lock->lk_type);
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7939  	status = nfs4_check_openmode(lock_stp, lkflg);
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7940  	if (status)
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7941  		goto out;
b34f27aa5da75b0 J. Bruce Fields      2011-08-22  7942  
0dd395dc76071a0 NeilBrown            2005-07-07  7943  	status = nfserr_grace;
3320fef19b542b8 Stanislav Kinsbursky 2012-11-14  7944  	if (locks_in_grace(net) && !lock->lk_reclaim)
0dd395dc76071a0 NeilBrown            2005-07-07  7945  		goto out;
0dd395dc76071a0 NeilBrown            2005-07-07  7946  	status = nfserr_no_grace;
3320fef19b542b8 Stanislav Kinsbursky 2012-11-14  7947  	if (!locks_in_grace(net) && lock->lk_reclaim)
0dd395dc76071a0 NeilBrown            2005-07-07  7948  		goto out;
0dd395dc76071a0 NeilBrown            2005-07-07  7949  
bb0a55bb7148a49 J. Bruce Fields      2021-08-20  7950  	if (lock->lk_reclaim)
60f3154d196b5b1 Jeff Layton          2024-01-31  7951  		flags |= FL_RECLAIM;
bb0a55bb7148a49 J. Bruce Fields      2021-08-20  7952  
11b9164adad7cd1 Trond Myklebust      2014-07-29  7953  	fp = lock_stp->st_stid.sc_file;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7954  	switch (lock->lk_type) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  7955  		case NFS4_READW_LT:
df561f6688fef77 Gustavo A. R. Silva  2020-08-23  7956  			fallthrough;
76d348fadff52e8 Jeff Layton          2016-09-16  7957  		case NFS4_READ_LT:
7214e8600eee146 Jeff Layton          2014-07-10  7958  			spin_lock(&fp->fi_lock);
eb82dd393744107 Jeff Layton          2019-08-18  7959  			nf = find_readable_file_locked(fp);
eb82dd393744107 Jeff Layton          2019-08-18  7960  			if (nf)
0997b173609b922 J. Bruce Fields      2011-03-02  7961  				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_READ);
7214e8600eee146 Jeff Layton          2014-07-10  7962  			spin_unlock(&fp->fi_lock);
60f3154d196b5b1 Jeff Layton          2024-01-31  7963  			type = F_RDLCK;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7964  			break;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7965  		case NFS4_WRITEW_LT:
df561f6688fef77 Gustavo A. R. Silva  2020-08-23  7966  			fallthrough;
76d348fadff52e8 Jeff Layton          2016-09-16  7967  		case NFS4_WRITE_LT:
7214e8600eee146 Jeff Layton          2014-07-10  7968  			spin_lock(&fp->fi_lock);
eb82dd393744107 Jeff Layton          2019-08-18  7969  			nf = find_writeable_file_locked(fp);
eb82dd393744107 Jeff Layton          2019-08-18  7970  			if (nf)
0997b173609b922 J. Bruce Fields      2011-03-02  7971  				get_lock_access(lock_stp, NFS4_SHARE_ACCESS_WRITE);
7214e8600eee146 Jeff Layton          2014-07-10  7972  			spin_unlock(&fp->fi_lock);
60f3154d196b5b1 Jeff Layton          2024-01-31  7973  			type = F_WRLCK;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7974  			break;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7975  		default:
^1da177e4c3f415 Linus Torvalds       2005-04-16  7976  			status = nfserr_inval;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7977  		goto out;
^1da177e4c3f415 Linus Torvalds       2005-04-16  7978  	}
76d348fadff52e8 Jeff Layton          2016-09-16  7979  
eb82dd393744107 Jeff Layton          2019-08-18  7980  	if (!nf) {
f9d7562fdb9dc0a J. Bruce Fields      2010-07-08  7981  		status = nfserr_openmode;
f9d7562fdb9dc0a J. Bruce Fields      2010-07-08  7982  		goto out;
f9d7562fdb9dc0a J. Bruce Fields      2010-07-08  7983  	}
aef9583b234a4ec Kinglong Mee         2014-08-22  7984  
7e64c5bc497cf17 Benjamin Coddington  2024-09-11  7985  	if (lock->lk_type & (NFS4_READW_LT | NFS4_WRITEW_LT) &&
7e64c5bc497cf17 Benjamin Coddington  2024-09-11  7986  		nfsd4_has_session(cstate) &&
7e64c5bc497cf17 Benjamin Coddington  2024-09-11  7987  		locks_can_async_lock(nf->nf_file->f_op))
7e64c5bc497cf17 Benjamin Coddington  2024-09-11  7988  			flags |= FL_SLEEP;
40595cdc93edf41 J. Bruce Fields      2021-12-16  7989  
76d348fadff52e8 Jeff Layton          2016-09-16  7990  	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
76d348fadff52e8 Jeff Layton          2016-09-16  7991  	if (!nbl) {
76d348fadff52e8 Jeff Layton          2016-09-16  7992  		dprintk("NFSD: %s: unable to allocate block!\n", __func__);
76d348fadff52e8 Jeff Layton          2016-09-16  7993  		status = nfserr_jukebox;
76d348fadff52e8 Jeff Layton          2016-09-16  7994  		goto out;
76d348fadff52e8 Jeff Layton          2016-09-16  7995  	}
76d348fadff52e8 Jeff Layton          2016-09-16  7996  
76d348fadff52e8 Jeff Layton          2016-09-16  7997  	file_lock = &nbl->nbl_lock;
05580bbfc6bcac9 Jeff Layton          2024-01-31  7998  	file_lock->c.flc_type = type;
05580bbfc6bcac9 Jeff Layton          2024-01-31  7999  	file_lock->c.flc_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
05580bbfc6bcac9 Jeff Layton          2024-01-31  8000  	file_lock->c.flc_pid = current->tgid;
05580bbfc6bcac9 Jeff Layton          2024-01-31  8001  	file_lock->c.flc_file = nf->nf_file;
05580bbfc6bcac9 Jeff Layton          2024-01-31  8002  	file_lock->c.flc_flags = flags;
21179d81f1de37c Jeff Layton          2012-08-21  8003  	file_lock->fl_lmops = &nfsd_posix_mng_ops;
21179d81f1de37c Jeff Layton          2012-08-21  8004  	file_lock->fl_start = lock->lk_offset;
21179d81f1de37c Jeff Layton          2012-08-21  8005  	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
21179d81f1de37c Jeff Layton          2012-08-21  8006  	nfs4_transform_lock_offset(file_lock);
21179d81f1de37c Jeff Layton          2012-08-21  8007  
21179d81f1de37c Jeff Layton          2012-08-21  8008  	conflock = locks_alloc_lock();
21179d81f1de37c Jeff Layton          2012-08-21  8009  	if (!conflock) {
21179d81f1de37c Jeff Layton          2012-08-21  8010  		dprintk("NFSD: %s: unable to allocate lock!\n", __func__);
21179d81f1de37c Jeff Layton          2012-08-21  8011  		status = nfserr_jukebox;
21179d81f1de37c Jeff Layton          2012-08-21  8012  		goto out;
21179d81f1de37c Jeff Layton          2012-08-21  8013  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  8014  
60f3154d196b5b1 Jeff Layton          2024-01-31  8015  	if (flags & FL_SLEEP) {
20b7d86f29d39e8 Arnd Bergmann        2019-11-04  8016  		nbl->nbl_time = ktime_get_boottime_seconds();
0cc11a61b80a1ab Jeff Layton          2016-10-20  8017  		spin_lock(&nn->blocked_locks_lock);
76d348fadff52e8 Jeff Layton          2016-09-16  8018  		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
7919d0a27f1e7cb Jeff Layton          2016-09-16  8019  		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
47446d74f170704 Vasily Averin        2021-12-17  8020  		kref_get(&nbl->nbl_kref);
0cc11a61b80a1ab Jeff Layton          2016-10-20  8021  		spin_unlock(&nn->blocked_locks_lock);
76d348fadff52e8 Jeff Layton          2016-09-16  8022  	}
76d348fadff52e8 Jeff Layton          2016-09-16  8023  
eb82dd393744107 Jeff Layton          2019-08-18  8024  	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
76d348fadff52e8 Jeff Layton          2016-09-16  8025  	switch (err) {
^1da177e4c3f415 Linus Torvalds       2005-04-16  8026  	case 0: /* success! */
9767feb2c64b297 Jeff Layton          2015-10-01  8027  		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
b8dd7b9ab194d9a Al Viro              2006-10-19  8028  		status = 0;
03f318ca652889a J. Bruce Fields      2018-06-08  8029  		if (lock->lk_reclaim)
03f318ca652889a J. Bruce Fields      2018-06-08  8030  			nn->somebody_reclaimed = true;
eb76b3fda1f7c2a Andy Adamson         2006-03-26  8031  		break;
76d348fadff52e8 Jeff Layton          2016-09-16  8032  	case FILE_LOCK_DEFERRED:
47446d74f170704 Vasily Averin        2021-12-17  8033  		kref_put(&nbl->nbl_kref, free_nbl);
76d348fadff52e8 Jeff Layton          2016-09-16  8034  		nbl = NULL;
df561f6688fef77 Gustavo A. R. Silva  2020-08-23  8035  		fallthrough;
76d348fadff52e8 Jeff Layton          2016-09-16  8036  	case -EAGAIN:		/* conflock holds conflicting lock */
eb76b3fda1f7c2a Andy Adamson         2006-03-26  8037  		status = nfserr_denied;
eb76b3fda1f7c2a Andy Adamson         2006-03-26  8038  		dprintk("NFSD: nfsd4_lock: conflicting lock found!\n");
21179d81f1de37c Jeff Layton          2012-08-21  8039  		nfs4_set_lock_denied(conflock, &lock->lk_denied);
eb76b3fda1f7c2a Andy Adamson         2006-03-26  8040  		break;
76d348fadff52e8 Jeff Layton          2016-09-16  8041  	case -EDEADLK:
^1da177e4c3f415 Linus Torvalds       2005-04-16  8042  		status = nfserr_deadlock;
eb76b3fda1f7c2a Andy Adamson         2006-03-26  8043  		break;
^1da177e4c3f415 Linus Torvalds       2005-04-16  8044  	default:
fd85b8170dabbf0 Marc Eshel           2006-11-28  8045  		dprintk("NFSD: nfsd4_lock: vfs_lock_file() failed! status %d\n",err);
3e77246393c0a43 J. Bruce Fields      2011-08-10  8046  		status = nfserrno(err);
eb76b3fda1f7c2a Andy Adamson         2006-03-26  8047  		break;
^1da177e4c3f415 Linus Torvalds       2005-04-16  8048  	}
^1da177e4c3f415 Linus Torvalds       2005-04-16  8049  out:
76d348fadff52e8 Jeff Layton          2016-09-16  8050  	if (nbl) {
76d348fadff52e8 Jeff Layton          2016-09-16  8051  		/* dequeue it if we queued it before */
60f3154d196b5b1 Jeff Layton          2024-01-31  8052  		if (flags & FL_SLEEP) {
0cc11a61b80a1ab Jeff Layton          2016-10-20  8053  			spin_lock(&nn->blocked_locks_lock);
47446d74f170704 Vasily Averin        2021-12-17  8054  			if (!list_empty(&nbl->nbl_list) &&
47446d74f170704 Vasily Averin        2021-12-17  8055  			    !list_empty(&nbl->nbl_lru)) {
76d348fadff52e8 Jeff Layton          2016-09-16  8056  				list_del_init(&nbl->nbl_list);
7919d0a27f1e7cb Jeff Layton          2016-09-16  8057  				list_del_init(&nbl->nbl_lru);
47446d74f170704 Vasily Averin        2021-12-17  8058  				kref_put(&nbl->nbl_kref, free_nbl);
47446d74f170704 Vasily Averin        2021-12-17  8059  			}
47446d74f170704 Vasily Averin        2021-12-17  8060  			/* nbl can use one of lists to be linked to reaplist */
0cc11a61b80a1ab Jeff Layton          2016-10-20  8061  			spin_unlock(&nn->blocked_locks_lock);
76d348fadff52e8 Jeff Layton          2016-09-16  8062  		}
76d348fadff52e8 Jeff Layton          2016-09-16  8063  		free_blocked_lock(nbl);
76d348fadff52e8 Jeff Layton          2016-09-16  8064  	}
eb82dd393744107 Jeff Layton          2019-08-18  8065  	if (nf)
eb82dd393744107 Jeff Layton          2019-08-18  8066  		nfsd_file_put(nf);
5db1c03feb00a72 Jeff Layton          2014-07-29  8067  	if (lock_stp) {
5db1c03feb00a72 Jeff Layton          2014-07-29  8068  		/* Bump seqid manually if the 4.0 replay owner is openowner */
5db1c03feb00a72 Jeff Layton          2014-07-29  8069  		if (cstate->replay_owner &&
5db1c03feb00a72 Jeff Layton          2014-07-29  8070  		    cstate->replay_owner != &lock_sop->lo_owner &&
5db1c03feb00a72 Jeff Layton          2014-07-29  8071  		    seqid_mutating_err(ntohl(status)))
5db1c03feb00a72 Jeff Layton          2014-07-29  8072  			lock_sop->lo_owner.so_seqid++;
5db1c03feb00a72 Jeff Layton          2014-07-29  8073  
5db1c03feb00a72 Jeff Layton          2014-07-29  8074  		/*
5db1c03feb00a72 Jeff Layton          2014-07-29  8075  		 * If this is a new, never-before-used stateid, and we are
5db1c03feb00a72 Jeff Layton          2014-07-29  8076  		 * returning an error, then just go ahead and release it.
5db1c03feb00a72 Jeff Layton          2014-07-29  8077  		 */
2502072058b35e2 J. Bruce Fields      2018-01-17  8078  		if (status && new)
5db1c03feb00a72 Jeff Layton          2014-07-29  8079  			release_lock_stateid(lock_stp);
beeca19cf1249a9 Trond Myklebust      2017-11-03  8080  
beeca19cf1249a9 Trond Myklebust      2017-11-03  8081  		mutex_unlock(&lock_stp->st_mutex);
5db1c03feb00a72 Jeff Layton          2014-07-29  8082  
3d0fabd5a48fbf6 Trond Myklebust      2014-07-29  8083  		nfs4_put_stid(&lock_stp->st_stid);
5db1c03feb00a72 Jeff Layton          2014-07-29  8084  	}
0667b1e9d8a7c0a Trond Myklebust      2014-07-29  8085  	if (open_stp)
0667b1e9d8a7c0a Trond Myklebust      2014-07-29  8086  		nfs4_put_stid(&open_stp->st_stid);
9411b1d4c7df26d J. Bruce Fields      2013-04-01  8087  	nfsd4_bump_seqid(cstate, status);
21179d81f1de37c Jeff Layton          2012-08-21  8088  	if (conflock)
21179d81f1de37c Jeff Layton          2012-08-21  8089  		locks_free_lock(conflock);
^1da177e4c3f415 Linus Torvalds       2005-04-16  8090  	return status;
^1da177e4c3f415 Linus Torvalds       2005-04-16  8091  }
^1da177e4c3f415 Linus Torvalds       2005-04-16  8092  

:::::: The code at line 7881 was first introduced by commit
:::::: 2dd10de8e6bcbacf85ad758b904543c294820c63 lockd: introduce safe async lock op

:::::: TO: Alexander Aring <aahringo@redhat.com>
:::::: CC: Chuck Lever <chuck.lever@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

