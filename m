Return-Path: <linux-kernel+bounces-237019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561391E9F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA32C28355A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928EC171089;
	Mon,  1 Jul 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="C1eOZReW";
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="YKa0Fzd/";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="lJD0C0v6"
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08578381C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.185.90.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867737; cv=none; b=egMsGGIc757Jv8e9/XQSODeHBvF+W3PrhG/Vjfurtke1knzw/we1XSe4L+qUNfLTGX2eZz8ZXuKXtD5qh95hWvrdH8po/IokMxW7G4RrmSAKYkcwzaIYJcd+yPCQXzBuZ17aeqpasiEJbBmuyCr2muA7tTmESeS7SCikvWlc65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867737; c=relaxed/simple;
	bh=IB1kAFJJPaiv0bb6ZBSdDIGxVRtB2wmUl4ZudMhgUZY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=L5HE9+7mX5dgNbZ56f0tpMgcy4R8NkVMTfVdWaN4giC78vsZOiHdNItzydjQXMtmArqqMjy1Ed6s6hQLexwNb/8rbTK9G+nJjqCKQCE4d65SG26ebCMNIVIOa/WSNx8/x191MEfvEhgXEy5xd92s6isIAlaWKcg+Lxb7uLXxMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de; spf=pass smtp.mailfrom=nerdbynature.de; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=C1eOZReW; dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=YKa0Fzd/; dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b=lJD0C0v6; arc=none smtp.client-ip=94.185.90.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1719867382; h=date : from : to : cc : subject : message-id :
 mime-version : content-type : from;
 bh=IB1kAFJJPaiv0bb6ZBSdDIGxVRtB2wmUl4ZudMhgUZY=;
 b=C1eOZReW3pWraviSXek0Ai7plkJjpJPLH3ZXVA6FvKBuVvT9s0wZ3A0CYCIaY/1szmYmx
 I/3VfepYXnuuQZODA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nerdbynature.de;
	s=dkim; t=1719867382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cybDmoysLtMDhMwr1zM9kI2BWPu18Ukegl6xV1lEoxA=;
	b=YKa0Fzd/PtVe5cuzyoYyVxn4nIRIGXExHbbAuE02WMf+wV6UrUl+nyxQZ3JqvR/T57JD//
	N39iEaKDjgneCXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1719867382; h=date : from :
 to : cc : subject : message-id : mime-version : content-type : from;
 bh=IB1kAFJJPaiv0bb6ZBSdDIGxVRtB2wmUl4ZudMhgUZY=;
 b=lJD0C0v6xdVqqYEjkWq0Vr+N0okPVpu7Jb0L4/WHUQfZEuuh2jp7/nhBMEGPPMNUFUUrm
 XGcafw9VvTPUALf1cjpo8W3AqboI10h+5VMLnFHb5ZR2d7ylm2eX13/SQ8iKskaS3JYf7AB
 lcGsYURzWX4gxrOze4c+wuGVVB91thIR8VJ8PFBbDBeYHJvpMChVTkFIjzAd4F0sBubl/CY
 Lj/MdhQS+CJPGeiNf+gctxEAPF/GzdjL2ky04xzfHCISdNuerb96P8lmH1JqRa0wClyavpg
 LMxmp20Fck8F4yNdlXPTeIqyQ9y3xuICWtGE3mDNuBXqXfgRT8smRk0JCKuA==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 30A2C5F901;
	Mon,  1 Jul 2024 22:56:22 +0200 (CEST)
Date: Mon, 1 Jul 2024 22:56:22 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: linux-kernel@vger.kernel.org
cc: Martin KaFai Lau <martin.lau@linux.dev>, 
    Alexei Starovoitov <ast@kernel.org>, 
    Daniel Borkmann <daniel@iogearbox.net>, 
    Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
    Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
    John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
    Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
    Jiri Olsa <jolsa@kernel.org>, regressions@lists.linux.dev, 
    patchwork-bot+netdevbpf@kernel.org, peter.ujfalusi@intel.com
Subject: =?utf-8?Q?=5Bregression=5D_bpf=5Flocal=5Fstorage=2Ec=3A785=3A60=3A_er?=
 =?utf-8?Q?ror=3A_=E2=80=98kvmalloc=5Farray=5Fnode=5Fnoprof=E2=80=99_s?=
 =?utf-8?Q?izes_specified_with_=E2=80=98sizeof=E2=80=99?=
Message-ID: <d0dd2457-ab58-1b08-caa4-93eaa2de221e@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=-11849954942852926061719867382198292

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---11849954942852926061719867382198292
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

This has been brought up before along with a patch[0] but has not been 
pushed to mainline:

 $ make allnoconfig
 $ enable CONFIG_WERROR and CONFIG_BPF
 $ make
 [...]
 kernel/bpf/bpf_local_storage.c: In function ‘bpf_local_storage_map_alloc’:
 kernel/bpf/bpf_local_storage.c:785:60: error: ‘kvmalloc_array_node_noprof’ sizes specified with ‘sizeof’ in the earlier 
   argument and not in the later argument [-Werror=calloc-transposed-args]
     785 |         smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
         |                                                            ^

I always compile kernels with CONFIG_WERROR=y and I'm surprised that this 
has not been caught by any build bots yet (or I did not see those 
reports), the help text even says "If in doubt, say Y", so I'm very 
puzzled why almost nobody else would be affected by this. The compilation 
error happens on a Fedora 40 laptop, with gcc 14.1.1 20240620 (Red Hat 
14.1.1-6) installed.

The fix posted in [0] does fix the compilation errors, but maybe never 
made it to the correct trees to be included upstream? We are already in 
-rc6 and I fear that the next release will be shipped with that problem.

Thanks,
Christian.

[0] https://lore.kernel.org/bpf/363ad8d1-a2d2-4fca-b66a-3d838eb5def9@intel.com/T/
-- 
BOFH excuse #424:

operation failed because: there is no message for this error (#1014)
---11849954942852926061719867382198292
Content-Type: application/gzip; name=config_error.txt.gz
Content-Transfer-Encoding: BASE64
Content-ID: <7cb96320-71f1-432a-b7d2-a809a0d47616@trent.utfs.org>
Content-Description: 
Content-Disposition: attachment; filename=config_error.txt.gz

H4sICI4Vg2YCA2NvbmZpZ19lcnJvci50eHQAnFxLl9s2st7nV/A4m2Rhp9/j
nHt6AZGghIgkaALUozc8ilq2dUYt9UjqxP73twrgAwBBOTNZON2oAohHPb4q
FPrnn34OyNv58LI6b9er3e578GWz3xxX581z8Hm72/xfEPEg4zKgEZMfgDnZ
7t++/fbt40Pw8OH66sPV++P6IZhujvvNLggP+8/bL2/Qe3vY//TzTyHPYjau
wrCa0UIwnlWSLuTju/U6+GUchr8G13cfrj9cBzdXN3dXDzdXwS8FfHayOteE
9w+/vjMGYaKCXo/fm6ZxN/Dj9d3V9dV1y5yQbNzSrppmItQYWdmNAU0N283d
9VXLmkTIOoqjjhWa/KwG4cqY7gTGJiKtxlzyipcyL2U3mEuXjEY9Jsl5IipR
5jkvZFXQpPAOwLKEZbRHyniVFzxmCa3irCJSGr1zMuHQ3u7ezUNDYcWnas6L
acc7KlkSSZbSSpIRdBIwGWOOk4IS2Kws5vAPsAjsCof/czBWkrQLTpvz22sn
DqOCT2lWgTSINO8GYhmTFc1mFSlgT1nK5OPtDYzSLIqnOS5FUiGD7SnYH844
cNN7TouCGwtMeEiSZnnv3nXjmISKlJJ7BlMrrgRJJHatGydkRqspLTKaVOMn
ZszcpIyAcuMnJU8p8VMWT0M9+BDhzk94EtKQWHu27RaYUzVX7zLghC/RF0+X
e/PL5LtLZFyI52QiGpMykUpYjLNpmidcyIyk9PHdL/vDfvOrce5iKWYsD73f
nBMZTqpPJS2plx4WXIgqpSkvlqhIJJx4+UpBEzbyTFsdESngI6QEOwpzASFM
Gj0BlQtOb3+evp/Om5dOT8Y0owULlUaCIo8MDTdJYsLnpjAUEbSC1ZiDwRA0
i/y9kFbMiEQtSHlkjI3UmBch2COt2ywbd1SRk0JQZFIStdk/B4fPzgo6K8zD
qeAljKW3OOLGSGo7TBZ1pt99nWckYRGRtEqIkFW4DBPPXigLNeu21iGr8eiM
ZlJcJFYpWDES/VEK6eFLuajKHOfi6F/OBVtUYV6qeRRCGULHkF7kUZIgty+b
48knDJOnKocp8IiFpiqDjQcKixK/4CqylzJh4wkKQT0Vj8z6Tq9KyaISUzoH
UQencd9JQG/mrS3NY2erKDRVf6izVouGX30rRq7uNNuJ1519VhsoZZYXbNba
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
sqrK9v8Byu1p6h2FAAA=

---11849954942852926061719867382198292--

