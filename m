Return-Path: <linux-kernel+bounces-236578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9191E440
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA9A1C22D67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59C16D308;
	Mon,  1 Jul 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgPa6N9o"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3B16CD03
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848171; cv=none; b=frphqkckwkkxGYmtYVAVw9rCYX0mxNAFW6DeHYfkOtthaIkLPRgXGtJ4ydjRcVV6h28clwZjp+Ydi15jeRfheGkMKq9A8GCUFS0S1KhDfzAX8NBXv1OwwetZ6P8SyU7z4GoZBkC1SI66MNvujfA9jyhxDiqXsjFv92/9b7AoHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848171; c=relaxed/simple;
	bh=IFMo+EgxtM+B2OQnWyCmG01tIkkhCDQlN5GI66q6Bq0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uU5YZLSa+AbL8J7taGmx4/GaM9A64JK745cfZudmklMSqGKQ7XB4ek3e0tiqdDhckMQjO12r6KERjNBxhziu5j6DKL/kIrK0ixdeBc/MN1S2wn6H28msHXUy0xoa4vRmml+fIBF86FJm5+sZdsfTgKwuSPGlODmkNTgxzzFYpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgPa6N9o; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-700d083b65bso2280625a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719848167; x=1720452967; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5bvCJAQ/Xchffz3t2J6NQaiVKI3Au7zTH9UDbhEV2c=;
        b=wgPa6N9oxOI3cluKe3Ioh1UaLxjt12NyTx6DfPYhBcy2V/7u6/np+2U7kM0HaC6de+
         pNbkraXcLySPZxycY4o4LssZ1WN1hmj+wHTL++iBdiwLFCnwPc7W0eL7UBwy0teFvdIu
         X2vBfiw5qThR7QftNJ+ymjrEK562Pu7z8gbBKTErn5MteKdQeYh9p4ZpN5GxPti4xJo9
         ZGy/108hR6muEma+rPhmJjDfkVE//eb/mFQxY4s8snWn9SflXgcdPaeMbXf6Y9I3THsI
         dWoccsxX22E0ji24tdBq+wD07b0FFkQ33OOK69TsUtXQhbzhzrQ8IaGTO2Qyenxm5JWU
         R/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848167; x=1720452967;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5bvCJAQ/Xchffz3t2J6NQaiVKI3Au7zTH9UDbhEV2c=;
        b=uOt5rL+GSlzamjwlHLfr936OZTEb+YFqxmp4mu/Ww5lOn8SDOAbF5hO2d9NkB+nSia
         vGJzZM2TiMwTzHLNF4OTPM7kKjppv5rCrXk59CNs2aF9cWzqAcd4T168y0sj/7cUuW29
         Sz/6LMIZu7vJCPLlCkJcIq8uTqZJbZXqBcs+NUXm2havNfH9y/9Zv9JVCZhwiNIZLZGM
         ivBXLccLVh/GK1RUkyb1sRpHNZo9/uswajrPVokFUB7f1ORDyUSmyh9QMfhISdo7N+ct
         swcdkIOqR4wlF9qqnJ14Q88bPh9XQeF+0y/hFlpQpz17HO+zsUkBzWdqcDKXJ/ZNnjhv
         1lsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/o8ZAKARhR5Cy3qHbVXbT9l8EfkoqnCIUyjdQi2wBqU5oioRyG7A2cY+7xQq8S1gQbMImgfXHEIQ45Z1+a7peyiVejLOQ+q9HmPgX
X-Gm-Message-State: AOJu0YyQJwUmFpFhjbFW9hgZQR8Joy3Q2IOZjAyTEtNLzLu3NTBHB2Be
	ViClQY1G6w2jh2kVqcMpA0YgFqqv0Xuemhu127qS63rZKKbHt1jo6k+Ok1Xvyms=
X-Google-Smtp-Source: AGHT+IFKq9w04b6QdUgSzMjtv3hGAqE/wViwGiHvkXfxi+QBNbw7E5hSpyBFPmF7DTfZhjYDni0mXA==
X-Received: by 2002:a05:6830:4a:b0:700:cf09:f512 with SMTP id 46e09a7af769-702075be678mr6912139a34.1.1719848167370;
        Mon, 01 Jul 2024 08:36:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e8c6:2364:637f:c70e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b3926fsm1325289a34.74.2024.07.01.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:36:06 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:36:05 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Filipe Manana <fdmanana@suse.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: fs/btrfs/ctree.c:612 btrfs_force_cow_block() error: we previously
 assumed 'parent' could be null (see line 548)
Message-ID: <96f65252-854d-4de4-a375-8f974a8bb884@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   55027e689933ba2e64f3d245fb1ff185b3e7fc81
commit: 95f93bc4cbcac6121a5ee85cd5019ee8e7447e0b btrfs: rename and export __btrfs_cow_block()
config: um-randconfig-r071-20240623 (https://download.01.org/0day-ci/archive/20240625/202406250719.jidL6tVI-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202406250719.jidL6tVI-lkp@intel.com/

New smatch warnings:
fs/btrfs/ctree.c:612 btrfs_force_cow_block() error: we previously assumed 'parent' could be null (see line 548)

vim +/parent +612 fs/btrfs/ctree.c
95f93bc4cbcac6 Filipe Manana             2023-09-27  513  int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
5f39d397dfbe14 Chris Mason               2007-10-15  514  			  struct btrfs_root *root,
5f39d397dfbe14 Chris Mason               2007-10-15  515  			  struct extent_buffer *buf,
5f39d397dfbe14 Chris Mason               2007-10-15  516  			  struct extent_buffer *parent, int parent_slot,
5f39d397dfbe14 Chris Mason               2007-10-15  517  			  struct extent_buffer **cow_ret,
9631e4cc1a030a Josef Bacik               2020-08-20  518  			  u64 search_start, u64 empty_size,
9631e4cc1a030a Josef Bacik               2020-08-20  519  			  enum btrfs_lock_nesting nest)
02217ed299c634 Chris Mason               2007-03-02  520  {
0b246afa62b0cf Jeff Mahoney              2016-06-22  521  	struct btrfs_fs_info *fs_info = root->fs_info;
5d4f98a28c7d33 Yan Zheng                 2009-06-10  522  	struct btrfs_disk_key disk_key;
5f39d397dfbe14 Chris Mason               2007-10-15  523  	struct extent_buffer *cow;
be1a5564fd39fa Mark Fasheh               2011-08-08  524  	int level, ret;
f0486c68e4bd9a Yan, Zheng                2010-05-16  525  	int last_ref = 0;
925baeddc5b076 Chris Mason               2008-06-25  526  	int unlock_orig = 0;
0f5053eb90f58c Goldwyn Rodrigues         2016-09-22  527  	u64 parent_start = 0;
60ea105a0f9fd3 Boris Burkov              2023-06-21  528  	u64 reloc_src_root = 0;
7bb86316c3961d Chris Mason               2007-12-11  529  
925baeddc5b076 Chris Mason               2008-06-25  530  	if (*cow_ret == buf)
925baeddc5b076 Chris Mason               2008-06-25  531  		unlock_orig = 1;
925baeddc5b076 Chris Mason               2008-06-25  532  
49d0c6424cf13a Filipe Manana             2021-09-22  533  	btrfs_assert_tree_write_locked(buf);
925baeddc5b076 Chris Mason               2008-06-25  534  
92a7cc4252231d Qu Wenruo                 2020-05-15  535  	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
0b246afa62b0cf Jeff Mahoney              2016-06-22  536  		trans->transid != fs_info->running_transaction->transid);
92a7cc4252231d Qu Wenruo                 2020-05-15  537  	WARN_ON(test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
27cdeb7096b86f Miao Xie                  2014-04-02  538  		trans->transid != root->last_trans);
5f39d397dfbe14 Chris Mason               2007-10-15  539  
7bb86316c3961d Chris Mason               2007-12-11  540  	level = btrfs_header_level(buf);
31840ae1a6b433 Zheng Yan                 2008-09-23  541  
5d4f98a28c7d33 Yan Zheng                 2009-06-10  542  	if (level == 0)
5d4f98a28c7d33 Yan Zheng                 2009-06-10  543  		btrfs_item_key(buf, &disk_key, 0);
5d4f98a28c7d33 Yan Zheng                 2009-06-10  544  	else
5d4f98a28c7d33 Yan Zheng                 2009-06-10  545  		btrfs_node_key(buf, &disk_key, 0);
5d4f98a28c7d33 Yan Zheng                 2009-06-10  546  
60ea105a0f9fd3 Boris Burkov              2023-06-21  547  	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID) {
60ea105a0f9fd3 Boris Burkov              2023-06-21 @548  		if (parent)
                                                                            ^^^^^^
The NULL checking in this function is not very consistent.  This warning
is possibly a false positive, but I expect that parent can't actually be
NULL and the NULL checks can be deleted.

5d4f98a28c7d33 Yan Zheng                 2009-06-10  549  			parent_start = parent->start;
60ea105a0f9fd3 Boris Burkov              2023-06-21  550  		reloc_src_root = btrfs_header_owner(buf);
60ea105a0f9fd3 Boris Burkov              2023-06-21  551  	}
79bd37120b1495 Filipe Manana             2021-06-29  552  	cow = btrfs_alloc_tree_block(trans, root, parent_start,
79bd37120b1495 Filipe Manana             2021-06-29  553  				     root->root_key.objectid, &disk_key, level,
60ea105a0f9fd3 Boris Burkov              2023-06-21  554  				     search_start, empty_size, reloc_src_root, nest);
54aa1f4dfdacd6 Chris Mason               2007-06-22  555  	if (IS_ERR(cow))
54aa1f4dfdacd6 Chris Mason               2007-06-22  556  		return PTR_ERR(cow);
6702ed490ca0bb Chris Mason               2007-08-07  557  
b4ce94de9b4d64 Chris Mason               2009-02-04  558  	/* cow is set to blocking by btrfs_init_new_buffer */
b4ce94de9b4d64 Chris Mason               2009-02-04  559  
58e8012cc12b3c David Sterba              2016-11-08  560  	copy_extent_buffer_full(cow, buf);
db94535db75e67 Chris Mason               2007-10-15  561  	btrfs_set_header_bytenr(cow, cow->start);
5f39d397dfbe14 Chris Mason               2007-10-15  562  	btrfs_set_header_generation(cow, trans->transid);
5d4f98a28c7d33 Yan Zheng                 2009-06-10  563  	btrfs_set_header_backref_rev(cow, BTRFS_MIXED_BACKREF_REV);
5d4f98a28c7d33 Yan Zheng                 2009-06-10  564  	btrfs_clear_header_flag(cow, BTRFS_HEADER_FLAG_WRITTEN |
5d4f98a28c7d33 Yan Zheng                 2009-06-10  565  				     BTRFS_HEADER_FLAG_RELOC);
5d4f98a28c7d33 Yan Zheng                 2009-06-10  566  	if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID)
5d4f98a28c7d33 Yan Zheng                 2009-06-10  567  		btrfs_set_header_flag(cow, BTRFS_HEADER_FLAG_RELOC);
5d4f98a28c7d33 Yan Zheng                 2009-06-10  568  	else
5f39d397dfbe14 Chris Mason               2007-10-15  569  		btrfs_set_header_owner(cow, root->root_key.objectid);
6702ed490ca0bb Chris Mason               2007-08-07  570  
de37aa513105f8 Nikolay Borisov           2018-10-30  571  	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
2b82032c34ec40 Yan Zheng                 2008-11-17  572  
be1a5564fd39fa Mark Fasheh               2011-08-08  573  	ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
b68dc2a93e794c Mark Fasheh               2011-08-29  574  	if (ret) {
572c83acdcdafe Josef Bacik               2020-09-29  575  		btrfs_tree_unlock(cow);
572c83acdcdafe Josef Bacik               2020-09-29  576  		free_extent_buffer(cow);
66642832f06a43 Jeff Mahoney              2016-06-10  577  		btrfs_abort_transaction(trans, ret);
b68dc2a93e794c Mark Fasheh               2011-08-29  578  		return ret;
b68dc2a93e794c Mark Fasheh               2011-08-29  579  	}
1a40e23b95da45 Zheng Yan                 2008-09-26  580  
92a7cc4252231d Qu Wenruo                 2020-05-15  581  	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
83d4cfd4da57b6 Josef Bacik               2013-08-30  582  		ret = btrfs_reloc_cow_block(trans, root, buf, cow);
93314e3b64fd2e Zhaolei                   2015-08-06  583  		if (ret) {
572c83acdcdafe Josef Bacik               2020-09-29  584  			btrfs_tree_unlock(cow);
572c83acdcdafe Josef Bacik               2020-09-29  585  			free_extent_buffer(cow);
66642832f06a43 Jeff Mahoney              2016-06-10  586  			btrfs_abort_transaction(trans, ret);
83d4cfd4da57b6 Josef Bacik               2013-08-30  587  			return ret;
83d4cfd4da57b6 Josef Bacik               2013-08-30  588  		}
93314e3b64fd2e Zhaolei                   2015-08-06  589  	}
3fd0a5585eb98e Yan, Zheng                2010-05-16  590  
02217ed299c634 Chris Mason               2007-03-02  591  	if (buf == root->node) {
925baeddc5b076 Chris Mason               2008-06-25  592  		WARN_ON(parent && parent != buf);

Checked here as well.

5d4f98a28c7d33 Yan Zheng                 2009-06-10  593  		if (root->root_key.objectid == BTRFS_TREE_RELOC_OBJECTID ||
5d4f98a28c7d33 Yan Zheng                 2009-06-10  594  		    btrfs_header_backref_rev(buf) < BTRFS_MIXED_BACKREF_REV)
5d4f98a28c7d33 Yan Zheng                 2009-06-10  595  			parent_start = buf->start;
925baeddc5b076 Chris Mason               2008-06-25  596  
406808ab2f0ba3 Filipe Manana             2021-03-11  597  		ret = btrfs_tree_mod_log_insert_root(root->node, cow, true);
40b0a749388517 Filipe Manana             2023-06-08  598  		if (ret < 0) {
40b0a749388517 Filipe Manana             2023-06-08  599  			btrfs_tree_unlock(cow);
40b0a749388517 Filipe Manana             2023-06-08  600  			free_extent_buffer(cow);
40b0a749388517 Filipe Manana             2023-06-08  601  			btrfs_abort_transaction(trans, ret);
40b0a749388517 Filipe Manana             2023-06-08  602  			return ret;
40b0a749388517 Filipe Manana             2023-06-08  603  		}
40b0a749388517 Filipe Manana             2023-06-08  604  		atomic_inc(&cow->refs);
240f62c8756df2 Chris Mason               2011-03-23  605  		rcu_assign_pointer(root->node, cow);
925baeddc5b076 Chris Mason               2008-06-25  606  
7a1636089acfee Filipe Manana             2021-12-13  607  		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
7a1636089acfee Filipe Manana             2021-12-13  608  				      parent_start, last_ref);
5f39d397dfbe14 Chris Mason               2007-10-15  609  		free_extent_buffer(buf);
0b86a832a1f38a Chris Mason               2008-03-24  610  		add_root_to_dirty_list(root);
02217ed299c634 Chris Mason               2007-03-02  611  	} else {
5d4f98a28c7d33 Yan Zheng                 2009-06-10 @612  		WARN_ON(trans->transid != btrfs_header_generation(parent));
                                                                                                                          ^^^^^^
No check for NULL.

d09c51521f22f9 Filipe Manana             2023-06-08  613  		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
33cff222faffef Filipe Manana             2022-10-14  614  						    BTRFS_MOD_LOG_KEY_REPLACE);
d09c51521f22f9 Filipe Manana             2023-06-08  615  		if (ret) {
d09c51521f22f9 Filipe Manana             2023-06-08  616  			btrfs_tree_unlock(cow);
d09c51521f22f9 Filipe Manana             2023-06-08  617  			free_extent_buffer(cow);
d09c51521f22f9 Filipe Manana             2023-06-08  618  			btrfs_abort_transaction(trans, ret);
d09c51521f22f9 Filipe Manana             2023-06-08  619  			return ret;
d09c51521f22f9 Filipe Manana             2023-06-08  620  		}
5f39d397dfbe14 Chris Mason               2007-10-15  621  		btrfs_set_node_blockptr(parent, parent_slot,
db94535db75e67 Chris Mason               2007-10-15  622  					cow->start);
74493f7a59bfd4 Chris Mason               2007-12-11  623  		btrfs_set_node_ptr_generation(parent, parent_slot,
74493f7a59bfd4 Chris Mason               2007-12-11  624  					      trans->transid);
50564b651d01c1 Filipe Manana             2023-09-12  625  		btrfs_mark_buffer_dirty(trans, parent);
5de865eebb8330 Filipe David Borba Manana 2013-12-20  626  		if (last_ref) {
f3a84ccd28d0b0 Filipe Manana             2021-03-11  627  			ret = btrfs_tree_mod_log_free_eb(buf);
5de865eebb8330 Filipe David Borba Manana 2013-12-20  628  			if (ret) {
572c83acdcdafe Josef Bacik               2020-09-29  629  				btrfs_tree_unlock(cow);
572c83acdcdafe Josef Bacik               2020-09-29  630  				free_extent_buffer(cow);
66642832f06a43 Jeff Mahoney              2016-06-10  631  				btrfs_abort_transaction(trans, ret);
5de865eebb8330 Filipe David Borba Manana 2013-12-20  632  				return ret;
5de865eebb8330 Filipe David Borba Manana 2013-12-20  633  			}
5de865eebb8330 Filipe David Borba Manana 2013-12-20  634  		}
7a1636089acfee Filipe Manana             2021-12-13  635  		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
7a1636089acfee Filipe Manana             2021-12-13  636  				      parent_start, last_ref);
02217ed299c634 Chris Mason               2007-03-02  637  	}
925baeddc5b076 Chris Mason               2008-06-25  638  	if (unlock_orig)
925baeddc5b076 Chris Mason               2008-06-25  639  		btrfs_tree_unlock(buf);
3083ee2e18b701 Josef Bacik               2012-03-09  640  	free_extent_buffer_stale(buf);
50564b651d01c1 Filipe Manana             2023-09-12  641  	btrfs_mark_buffer_dirty(trans, cow);
2c90e5d658424b Chris Mason               2007-04-02  642  	*cow_ret = cow;
02217ed299c634 Chris Mason               2007-03-02  643  	return 0;
02217ed299c634 Chris Mason               2007-03-02  644  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


