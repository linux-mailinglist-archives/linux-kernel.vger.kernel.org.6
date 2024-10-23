Return-Path: <linux-kernel+bounces-377246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3C9ABBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB0D28144B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804AF78C90;
	Wed, 23 Oct 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+/10goN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3173176;
	Wed, 23 Oct 2024 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652166; cv=none; b=Dt6tN0Uif31an+O/b49meVxyvJZTmwjiAWWGkAmrmSsmOCoM38WAZ7d/u8KO2vd9k10eEnfFwV7rgLpoDJRuUfvrzU942DrdZEPB5BUGBO4IwCalsUQ/8oXKWRvQSEzz783yq6GcSNJ6BW90hYbaEpXatGnWF5IShMTPILhrkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652166; c=relaxed/simple;
	bh=J2u0C5mSs3EyGPWkTG27EJp/N7slHUhvoOj+4BR5hTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2ze0JwI0cT0PU8oymvf1zEEYw1QWecCqXt35SLkxmdQ0xefBzr1tQ1FbnTJ7D9Tn0zNso3stKdCxmqXWKMJHLGCUKLSexahenVv8jr2vAaOgiKciuKwN5m8S622JynFyIBoBSufLzHsOaOU5IZycYUMGYoIJ9by3WSeIllhAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+/10goN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729652164; x=1761188164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J2u0C5mSs3EyGPWkTG27EJp/N7slHUhvoOj+4BR5hTI=;
  b=j+/10goN0nRgmGSZQ6URQ5DUG+ADXr+BvgRRxzyQffyhOJl0USSTd7Ji
   TzmXOOH8+fzt6Ry7HZccgomlGBD+nV07OXh3iuWatbPV4FLHfcknvwcWT
   T8m0cDWkPjy4eDgMH93kOJl1mA+epKFcyz2Hf313F0YQJv87xWXGn3WH1
   6Datn/MGJHdDYHJhOXAk88POWsTY/D4nzyJZrXpJeA+PdMrGsv4K1KNK8
   YraFi2kx8d0dyytjwW40NyZ5vlmWXCiyDMA7c6GmRTQFvS9Nh876c+Yyw
   tu+sR2qD84MQLCjdsvLHzNyshpJp0mcGGj/CNt6V2tIgxeeH/FWAGP5Ko
   g==;
X-CSE-ConnectionGUID: C+CRFaK8Qxq76V0O7pCL9w==
X-CSE-MsgGUID: PpBrnMNbQu+akci39rl2IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29322587"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29322587"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:56:03 -0700
X-CSE-ConnectionGUID: Rq4/563ETEmFOU9gjW1iuQ==
X-CSE-MsgGUID: MPUaqxqpQ7CYnhynDk98UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79975476"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:56:00 -0700
Date: Wed, 23 Oct 2024 10:55:06 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org,
	yi1.lai@intel.com, syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata: Clear DID_TIME_OUT for ATA PT commands
 with sense data
Message-ID: <ZxhligS6bR+svgRk@ly-workstation>
References: <20240909154237.3656000-2-cassel@kernel.org>
 <ZxYz871I3Blsi30F@ly-workstation>
 <ZxZD-doogmnZGfRI@ryzen.lan>
 <ZxZxLK7eSQ_bwkLe@ryzen.lan>
 <Zxc7qLHYr60FJrD4@ly-workstation>
 <ZxdmxPAgNh9TNCU+@x1-carbon.wireless.wdc>
 <Zxd2hZWt1zm4eW2q@ly-workstation>
 <ZxeGqrEpdg9Df5FS@ryzen>
 <ZxfL0Q023hSgzdI5@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxfL0Q023hSgzdI5@ryzen>

On Tue, Oct 22, 2024 at 05:59:13PM +0200, Niklas Cassel wrote:
> On Tue, Oct 22, 2024 at 01:04:10PM +0200, Niklas Cassel wrote:
> > On Tue, Oct 22, 2024 at 05:55:17PM +0800, Lai, Yi wrote:
> > > On Tue, Oct 22, 2024 at 10:48:04AM +0200, Niklas Cassel wrote:
> > > > On Tue, Oct 22, 2024 at 01:44:08PM +0800, Lai, Yi wrote:
> > > > > On Mon, Oct 21, 2024 at 05:20:12PM +0200, Niklas Cassel wrote:
> > > > > > On Mon, Oct 21, 2024 at 02:07:21PM +0200, Niklas Cassel wrote:
> > > > > > > Hello Yi Lai,
> > > > > > > 
> > > > > > > On Mon, Oct 21, 2024 at 06:58:59PM +0800, Lai, Yi wrote:
> > > > > > > > Hi Niklas Cassel,
> > > > > > > > 
> > > > > > > > Greetings!
> > > > > > > > 
> > > > > > > > I used Syzkaller and found that there is INFO: task hung in blk_mq_get_tag in v6.12-rc3
> > > > > > > > 
> > > > > > > > After bisection and the first bad commit is:
> > > > > > > > "
> > > > > > > > e5dd410acb34 ata: libata: Clear DID_TIME_OUT for ATA PT commands with sense data
> > > > > > > > "
> > > > > > > 
> > > > > > > It might be that your bisection results are accurate.
> > > > > > > 
> > > > > > > However, after looking at the stacktraces, I find it way more likely that
> > > > > > > bisection has landed on the wrong commit.
> > > > > > > 
> > > > > > > See this series that was just queued (for 6.13) a few days ago that solves a
> > > > > > > similar starvation:
> > > > > > > https://lore.kernel.org/linux-block/20241014092934.53630-1-songmuchun@bytedance.com/
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block
> > > > > > > 
> > > > > > > You could perhaps run with v6.14-rc4 (which should be able to trigger the bug)
> > > > > > > and then try v6.14-rc4 + that series applied, to see if you can still trigger
> > > > > > > the bug?
> > > > > >
> > > 
> > > I tried kernel linux-block
> > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> > > branch for-6.13/block commit c97f91b1807a7966077b69b24f28c2dbcde664e9.
> > > 
> > > Issue can still be reproduced.
> > 
> > Thanks again for your testing!
> > 
> > I will try to reproduce using your reproducer (repo.c),
> > and see if I can make any sense of this.
> 
> Hello Yi Lai,
> 
> 
> An important thing that I noticed is that even when I look at your good commit
> (v5.11) - the first commit you marked as as good in git bisect, it has this:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241018_105830_blk_mq_get_tag/f40ddce88593482919761f74910f42f4b84c004b_dmesg.log
> 
> [  300.525626]  __schedule+0xb9f/0x2eb0^M
> [  300.525843]  ? __pfx___schedule+0x10/0x10^M
> [  300.526056]  ? lock_release+0x441/0x870^M
> [  300.526286]  ? __pfx_lock_release+0x10/0x10^M
> [  300.526512]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20^M
> [  300.526801]  ? kthread_data+0x61/0xd0^M
> [  300.527007]  schedule+0xf6/0x3f0^M
> [  300.527225]  io_schedule+0xce/0x150^M
> [  300.527408]  rq_qos_wait+0x1c5/0x310^M
> [  300.527610]  ? __pfx_wbt_cleanup_cb+0x10/0x10^M
> [  300.527847]  ? __pfx_rq_qos_wait+0x10/0x10^M
> [  300.528070]  ? __pfx_lock_release+0x10/0x10^M
> [  300.528296]  ? __pfx_rq_qos_wake_function+0x10/0x10^M
> [  300.528562]  ? __pfx_wbt_inflight_cb+0x10/0x10^M
> [  300.528806]  ? do_raw_spin_unlock+0x15c/0x210^M
> [  300.529048]  wbt_wait+0x1ec/0x400^M
> 
> In fact, most *_dmesg.log logs in your syzlog directory has a stack trace that
> contains a "blocked for more than 147 seconds" error.
> Many of these logs are (with the "blocked for more than 147 seconds" error)
> are commits that your bisect script has classified as "good".
> 
> 
> If we look at your own dmesg with Linux 6.12-rc3 + e5dd410acb34 reverted,
> which passes your git bisect script, even if it has a
> "blocked for more than 147 seconds" error:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241018_105830_blk_mq_get_tag/8e929cb546ee42c9a61d24fae60605e9e3192354_e5dd410acb34c7341a0a93b429dcf3dabf9e3323_revert_dmesg.log
> It seems that the reason is because you don't find "blk_mq_get_tag" in dmesg:
> |1019_054406|/var/www/html/bzimage/bzImage_8e929cb546ee42c9a61d24fae60605e9e3192354_e5dd410acb34c7341a0a93b429dcf3dabf9e3323_revert didn't contain blk_mq_get_tag: in dmesg, pass|
> |1019_054406|Bisect successfully! 8e929cb546ee42c9a61d24fae60605e9e3192354_e5dd410acb34c7341a0a93b429dcf3dabf9e3323_revert bzimage passed!|
> 
> So it seems that both v5.11 and "v6.12-rc3 + e5dd410acb34 reverted" has
> problems.
> 
> 
> I managed to reproduce using your reproducer, and with
> v6.12-rc4 + e5dd410acb34 reverted, I see:
> [  299.641187]  __schedule+0x1144/0x3200
> [  299.641425]  ? __pfx___schedule+0x10/0x10
> [  299.641651]  ? lock_release+0x4b0/0x870
> [  299.641868]  ? debug_smp_processor_id+0x1b/0x30
> [  299.642128]  ? __pfx_lock_release+0x10/0x10
> [  299.642362]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  299.642640]  ? lock_acquire+0x80/0xb0
> [  299.642852]  ? schedule+0x202/0x3d0
> [  299.643068]  schedule+0xe7/0x3d0
> [  299.643261]  io_schedule+0x96/0x100
> [  299.643494]  bit_wait_io+0x17/0xf0
> [  299.643703]  __wait_on_bit_lock+0x118/0x1a0
> [  299.643941]  ? __pfx_bit_wait_io+0x10/0x10
> [  299.644195]  out_of_line_wait_on_bit_lock+0xe8/0x120
> [  299.644475]  ? __pfx_out_of_line_wait_on_bit_lock+0x10/0x10
> [  299.644793]  ? __pfx_wake_bit_function+0x10/0x10
> [  299.645060]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  299.645344]  __lock_buffer+0x72/0x80
> [  299.645569]  do_get_write_access+0x7d0/0x1130
> [  299.645838]  jbd2_journal_get_write_access+0x1e9/0x270
> [  299.646136]  __ext4_journal_get_write_access+0x72/0x3b0
> [  299.646436]  ext4_reserve_inode_write+0x145/0x280
> 
> So even with e5dd410acb34 reverted, we see a problem!
> 
> 
> 
> The difference seems to be the stack trace before and after e5dd410acb34 is
> slightly different.
> Before e5dd410acb34 the stack trace often looks like one of the two above.
> After e5dd410acb34 the stack trace instead always has blk_mq_get (and seems
> to be easier to reproduce).
> 
> 
> I think that the stack trace that contains "blk_mq_get" actually indicates a
> new problem though, so thank you for that!
> 
> I have a fix for it:
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index fa41ea57a978..3b303d4ae37a 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -651,6 +651,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>                         /* the scmd has an associated qc */
>                         if (!(qc->flags & ATA_QCFLAG_EH)) {
>                                 /* which hasn't failed yet, timeout */
> +                               set_host_byte(scmd, DID_TIME_OUT);
>                                 qc->err_mask |= AC_ERR_TIMEOUT;
>                                 qc->flags |= ATA_QCFLAG_EH;
>                                 nr_timedout++;
> 
> 
> 
> I will post it as a real fix for the new problem (blk_mq_get) tomorrow.
>

I applied this fix on top of linux v6.12-rc4. The new problem
cannot be reproduced.

If possible, please help add reported-by tag.

> This just solves the new problem though.
> 
> You probably need to do another bisection to find the problem that exists on
> v5.11 and earlier kernels.

Thanks for the analysis. It indeed gives direction for me to further improve the
issue reproduction and bisection handling flow. I will follow up.

Regards,
Yi Lai

> 
> 
> Kind regards,
> Niklas

