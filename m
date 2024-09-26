Return-Path: <linux-kernel+bounces-339866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F4986B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF9C1C21C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35417A918;
	Thu, 26 Sep 2024 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARynUzyG"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F701741C6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322895; cv=none; b=om2txKw4bfCNvP3htmVj4BgwiHdoFa6IGYq2LRzFMizMLgJPP8cTuqARxpbNLTNgv8aIdRNx356FsergEh0W3QHL8neCpYVUrgmCSGRteTDCM7vQOMtV8gNxv056Fk3BL6HnD1Mb6pqwwQxWY+4Vy7RjDu0nRDrrMCPGrfzqOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322895; c=relaxed/simple;
	bh=bRk22HAym20sHlimvzAEGWBmWC5p/OatRlP5cy3ycEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLIvF60ERoMlc+Dze6IBe1PvenEnwwiN8cd31ey7sMVNSjKhvtEEJbeJgjjiVAqj0AoCNMNOutnCgEYetMJ6fyNBHjJSUt16PstpKC0jtS4QPPm8i7NtCEHyVfWnBVQb2MWntdIrpfusuh7sxziwL+KpCxSIBJOtLh4nI6Br1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ARynUzyG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2056aa5cefcso129075ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727322891; x=1727927691; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4nHDP6dcE0ua4gmTBMCeuS8PV3g0/4IEyr8GgNGo1VY=;
        b=ARynUzyGSO+MHhbYV7r165DksEdDBGdh2C6OX+QLBL6R7Rfn8Vv3K4MYkz7izduQ8r
         IAc4ogQpsJRO6s7SIKkSuWiFRfVkLrOi0N+aFN2vi3rv3AL726mbpki96MQwgil6XtIh
         VjrGPQSWOm1GAzFeoLtiiisq89ykFDxEZDbA8UIa6KEMmpdLyZt4UvWY/vFsPmbn7wp6
         /tDAvnHQE6TIfPUV+l86ub7QJnP1UGNsA2u/zJr7/LP5FjJIYZjfmuqbOuLnDrxuxtpc
         mecmKO5il49kDWwmk1ERm1PyRPv3RFenZxgEa4m0HQAPqHEQJD9kFbvwnVDRWAHVlaep
         7i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727322891; x=1727927691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nHDP6dcE0ua4gmTBMCeuS8PV3g0/4IEyr8GgNGo1VY=;
        b=JJdkLhZ0ckV7IFUGi6CROB0IZFYu8rDvtkBdAhmblXCzUQpwoyvEe+LH08tlrHkp3M
         roQB9k0t5InTBn+UNjti64lINTRTPDSsLFHtwSLHn7m2G0Hp2Mf7I6fyZ66Me5TvXvpj
         tqRLuYiCr6wtGaa6rRWvrOPwdkeZdaxeKZ1Rla6dmiNGkVMBXFtwKlQfInvF4ecXNK4b
         Cdi5yDOKVcTLPCUUF8LG5lJTC4tZt08wZlvW6uCFolcDvGMrQoCJ+/Aa3EdwnXuGlkUl
         aAMNAO1XJDe81uc+JX3T9Ep7MAJk6Vlcs9rHHilCCBOlMV/ClfzoDWkYSbZ4032bXEF1
         4/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCURiVxtR9uDU4+xDxQwNIp+yKwrZfI3hmRc9z7sRS0MoATgVtJIjNnoO+KyOOWshf0qXNkuIYZ27ypMryA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5EXJ2a1eGZaGh00RIUBS4mDxdqwAtrNm1xncgReFnsKrSzEX
	mengi7l/73/2l8Y/NaPOsys7eat7TedAMblSa/KcFJ6bIZfqb4VRvLAEFUmNkg==
X-Google-Smtp-Source: AGHT+IGhYXfpTPvo78l2nPppnHUtOCUp2APzySTwHpohpa4aUJuZLR+bz87mU2/Hl7Kn5MK0s2uKNw==
X-Received: by 2002:a17:903:2302:b0:205:8ceb:79a7 with SMTP id d9443c01a7336-20b2039164bmr1147265ad.23.1727322891403;
        Wed, 25 Sep 2024 20:54:51 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b0f8b1d1dsm9990905ad.298.2024.09.25.20.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 20:54:50 -0700 (PDT)
Date: Thu, 26 Sep 2024 03:54:46 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yu-Ting Tseng <yutingtseng@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
Message-ID: <ZvTbBkMqtoG754Hr@google.com>
References: <20240924184401.76043-1-cmllamas@google.com>
 <20240924184401.76043-5-cmllamas@google.com>
 <CAH5fLgiDjNtt2G4S4NrHLGvGudSVT1udCKjkpTC+71v_3TuLZg@mail.gmail.com>
 <ZvRHlmCSwGHbH70z@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvRHlmCSwGHbH70z@google.com>

On Wed, Sep 25, 2024 at 05:25:42PM +0000, Carlos Llamas wrote:
> On Wed, Sep 25, 2024 at 09:36:10AM +0200, 'Alice Ryhl' via kernel-team wrote:
> > On Tue, Sep 24, 2024 at 8:44 PM Carlos Llamas <cmllamas@google.com> wrote:
> > >
> > > The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
> > > entries and it shows up as "unknown work" when logged:
> > >
> > >   proc 649
> > >   context binder-test
> > >     thread 649: l 00 need_return 0 tr 0
> > >     ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
> > >     unknown work: type 10
> > >
> > > This patch add the freeze work type and is now logged as such:
> > >
> > >   proc 637
> > >   context binder-test
> > >     thread 637: l 00 need_return 0 tr 0
> > >     ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
> > >     has frozen binder
> > >
> > > Fixes: d579b04a52a1 ("binder: frozen notification")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > >  drivers/android/binder.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index d955135ee37a..2be9f3559ed7 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -6408,6 +6408,9 @@ static void print_binder_work_ilocked(struct seq_file *m,
> > >         case BINDER_WORK_CLEAR_DEATH_NOTIFICATION:
> > >                 seq_printf(m, "%shas cleared death notification\n", prefix);
> > >                 break;
> > > +       case BINDER_WORK_FROZEN_BINDER:
> > > +               seq_printf(m, "%shas frozen binder\n", prefix);
> > > +               break;
> > 
> > What about BINDER_WORK_CLEAR_FREEZE_NOTIFICATION?
> 
> Oh, you are right! We also need this type here. I haven't played with
> the clear notification path just yet (as you can tell). Thanks for
> pointing it out though, I'll send a v2.
> 
> Looking closer, I see that BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT
> is also missing, so I'll send a separate patch for that too.

After playing with clear-freeze I've also found a memleak. This work is
not being released unless it is processed. I'll add one more patch to
the v2 series fixing it (tomorrow).

unreferenced object 0xffff03ced63cd280 (size 64):
  comm "binder-util", pid 947, jiffies 4295183379
  hex dump (first 32 bytes):
    80 d2 3c d6 ce 03 ff ff 80 d2 3c d6 ce 03 ff ff  ..<.......<.....
    0b 00 00 00 00 00 00 00 3c 1f 4a 00 00 00 00 00  ........<.J.....
  backtrace (crc 718d20df):
    [<00000000188a0477>] kmemleak_alloc+0x34/0x40
    [<00000000fe1c45bc>] __kmalloc_cache_noprof+0x208/0x280
    [<000000005ebe1c53>] binder_thread_write+0xdec/0x439c
    [<000000004b0e4ffa>] binder_ioctl+0x1b68/0x22cc
    [<000000001786d65d>] __arm64_sys_ioctl+0x124/0x190
    [<00000000fb1e34f9>] invoke_syscall+0x6c/0x254
    [<00000000826a09b6>] el0_svc_common.constprop.0+0xac/0x230
    [<000000004389c74d>] do_el0_svc+0x40/0x58
    [<000000008b9dd949>] el0_svc+0x38/0x78
    [<00000000c66f77b2>] el0t_64_sync_handler+0x120/0x12c
    [<00000000a4cd389b>] el0t_64_sync+0x190/0x194> 

--
Carlos Llamas

