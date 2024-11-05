Return-Path: <linux-kernel+bounces-396492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E19BCDE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A811C217F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCC71D8A12;
	Tue,  5 Nov 2024 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="CzZ1FOmf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z51+AR1D"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA01D63D4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813607; cv=none; b=KScr6bAc3k3ZMK0UJb0vGTPK7BI40wdMQt8CpgGdD/PI6Rnh1Wcl1UfZgGrTfbOLI9RIrpopTZAWY/nk8kAyErEf/QilL5xTEdXWqyisDuMHJDyus8mNG8HVjf+TqOulxNnftQbRngupv/77GBMMlTNA8JuAFuHA9/5r8POJzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813607; c=relaxed/simple;
	bh=XwfmOZIy08nckcVke8MkEpepgThfDK7UYTFsWDhfm/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io3l8V668DtwlG76/eDoUondaiSm8nseWiM0Edm5/rn0hfzSUGV00Epv+EDJSHPQMawp770pCI5/9ITE7mSXDE0ncy1vBpNkfx7g+F21A931+ik0vZBwWWIlweFeb2X9baw2m77AbqpbxSXpPUjI3AGENf0pbrpX1FxlB4L1Y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=CzZ1FOmf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z51+AR1D; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89EC2254010A;
	Tue,  5 Nov 2024 08:33:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 08:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730813603; x=
	1730900003; bh=yG23YdcZfpaqVlw+HXapkVu6cxVlnWa2fc6M1+j92/c=; b=C
	zZ1FOmf76uxyhQeH/OXpqSm5cSfbW/shWJkzMuyY5Iohjxm+z63X0AlwdsBURoFK
	TwTMd8CK66/aUAIu/vf2tL/wlmN40Tm7G9pnhu10Tc2mEVW0rSxh8ZYNDVF26Jxm
	8QxVEp+ySjwchpt2Tt6TGUB1tADp2jbBAs3Oz3GibtJ6C1oPQ29uHA1TTqg+5jiW
	G+HRiI7ZEFhoJzuqho6j3bxzakP7GLX46+gCvk9Bl7W8h3gc3Y2NcgkVWEAD2RJG
	ZTgD0HWD0Xiv4miTc1G9z/z1fd6fDnL996jaH+mlQRyShuXPptHpkqjvAfrZhTuO
	JKbym+D1E06qlHx+cVe3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730813603; x=1730900003; bh=yG23YdcZfpaqVlw+HXapkVu6cxVlnWa2fc6
	M1+j92/c=; b=Z51+AR1DcRBK2xDEh6UmH4ipXksqSmSTA8yMaVp6tKzhWUFvPv7
	ln9dGVh8mtefSjHwfIiubbFYb4CNRgK0+3tFzUE15wsgL2fLnzxTZ1VKjjH7aoKU
	3ZLhewKqFDWb6T/IrnaaTd/eaU/dJhj3z89tx+ht3zSXpbma0bglmWtH80hRPpV1
	qBFeKA6II9a8lH9rcBbVJgviJWz4kTdVNC7sp65n9ozpUJOgUSlOuz/I58s7m2C6
	ZkqQa1kNf69BGYBFRikdGx5ewCvPtOfmj8M+D3O7mIXAT5Ux23NAcEmJjhfXyfjA
	G2xyae4+4V666t9wmRWCEZlE0tGHDyecYGA==
X-ME-Sender: <xms:ox4qZ6XVYD713hqd8MnuswQ5A7Lf7QLXfPMPMy4ju5uOLEc3GFRJdg>
    <xme:ox4qZ2lRP-HbKajECyNbz_GT3EUkNLR2XxTjdMrtYrZUvN7Ao6KFQsosMW1Y03LLL
    imJWEtnecRDeV1TQT0>
X-ME-Received: <xmr:ox4qZ-ZXRt0MVd8TN7WbyU4nbzUTBTQBqEi0590UzRYshc2juYuVS3QC3eSbdU0iY2KG2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhu
    thgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeeltedugedtgfehudduhfetleeiuedvtdehieejjedufeejfeegteetuddt
    gefgudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehshiiisghothdotdefvgdurghfhegtfeefvdhfjegvtdgvsgekgegssehshiiikhgr
    lhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshihiihkrghl
    lhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:ox4qZxV91yoQsTpI_9g8XTlx4h8KUI0FPJP8b172xM9EmUb4odVGyA>
    <xmx:ox4qZ0nkwJnGNj8y0m7bQ3l37sNISuXfSMojVpt1kPNcy8UEv8DR-w>
    <xmx:ox4qZ2dlbQb9Urb7BdRyv9oxjJhUu_0kGxR9ltXowCCzVh3ITLNsug>
    <xmx:ox4qZ2FIQEUt0SVnt2XUjkJDumseMAIB3iQUyyOXPQdDuueWKWanMw>
    <xmx:ox4qZ-hwoEzQSaVcA-DAStLk9nXsyO9zCUDsfIT5daIpIZ9iqLvqIE3r>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 08:33:21 -0500 (EST)
Date: Tue, 5 Nov 2024 15:33:16 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: syzbot <syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Re: kernel BUG in free_bprm()
Message-ID: <ne4dsdjh7tcp7ndgqa7qx2ouhkioowr52wunfnikykq5v2z2zs@tfshc7af2eql>
References: <6729d8d1.050a0220.701a.0017.GAE@google.com>
 <6729fedf.050a0220.701a.001b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6729fedf.050a0220.701a.001b.GAE@google.com>

On Tue, Nov 05, 2024 at 03:17:51AM -0800, syzbot wrote:
> For archival purposes, forwarding an incoming command email to
> linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.
> 
> ***
> 
> Subject: Re: kernel BUG in free_bprm()
> Author: dmantipov@yandex.ru
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next 850f22c42f4b0a14a015aecc26f46f9948ded6dd
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index ef18eb0ea5b4..df70ed8e36fe 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1496,7 +1496,8 @@ static void free_bprm(struct linux_binprm *bprm)
>  	if (bprm->interp != bprm->filename)
>  		kfree(bprm->interp);
>  	kfree(bprm->fdpath);
> -	kfree(bprm->argv0);
> +	if (!IS_ERR(bprm->argv0))
> +		kfree(bprm->argv0);
>  	kfree(bprm);
>  }

It's better to avoid setting bprm->argv0 if strndup_user() fails.

diff --git a/fs/exec.c b/fs/exec.c
index ef18eb0ea5b4..9380e166eff5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1504,6 +1504,7 @@ static int bprm_add_fixup_comm(struct linux_binprm *bprm,
 			       struct user_arg_ptr argv)
 {
 	const char __user *p = get_user_arg_ptr(argv, 0);
+	char *argv0;
 
 	/*
 	 * If p == NULL, let's just fall back to fdpath.
@@ -1511,10 +1512,11 @@ static int bprm_add_fixup_comm(struct linux_binprm *bprm,
 	if (!p)
 		return 0;
 
-	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
-	if (IS_ERR(bprm->argv0))
-		return PTR_ERR(bprm->argv0);
+	argv0 = strndup_user(p, MAX_ARG_STRLEN);
+	if (IS_ERR(argv0))
+		return PTR_ERR(argv0);
 
+	bprm->argv0 = argv0;
 	return 0;
 }
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

