Return-Path: <linux-kernel+bounces-228923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B49168B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151011F22294
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E215E5CB;
	Tue, 25 Jun 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQoy/7Z+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54641509A2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321623; cv=none; b=avV846b55WRwWWe4G1hC7NGDIxY2ROClVUJ5BAeTmJsd5GJjf2lcYMyXR5pfW7RL/tcQ2uyGN3iFa5haWvhIKWo1vgJVL4T03sDbt82NDTSPAqM+NzfdEBpcfTSQuJq8Q9RSo2KFGUDszaP+Ehu1h/q1Ncik6mpsVC3oGfExIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321623; c=relaxed/simple;
	bh=FJKwbxdNDPaagwidpNrj4XDCTGChY7nsi02qsMfyunk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clk1yuqVuxxRGKsNrAk986qHfGHe9sakk44pFC+B+YDctSFoDEvsI7sWvO4Hndkukmn7Q7ZSUTB+Abyz3GQ3gzJ3sdiAmFFVtujaerih/o1kq2fb/6MK8XpfjYnQVP0AsZ2CBfA97PEqaigRl3+LaVgqgIm5pKg3UKFInXsjasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQoy/7Z+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719321620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDb0f9AvirN6Qh+jjNYSAg2Q67veraPkDqA1IxWMfm0=;
	b=ZQoy/7Z+CqubRvRZ+1NfiWXXYhDQxtdjEwrs/IwNe0plXO+Otn0ZeFSG2WKXnaH7Gf+Ya2
	9PuRTVy4GT2DtyAC/bMgGOuR9+6x3Mdm6ojO3WrNCGcFRE+cOs8NPZEv98u+NQUoGNGgpB
	Uxb0qxv19fQdliUT3/Pgwj/u0xCFreM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-aq3oMAD6PqWcXrh2tqtA2w-1; Tue, 25 Jun 2024 09:20:19 -0400
X-MC-Unique: aq3oMAD6PqWcXrh2tqtA2w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79559142ab3so908556385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321618; x=1719926418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDb0f9AvirN6Qh+jjNYSAg2Q67veraPkDqA1IxWMfm0=;
        b=HVi140E5zLIl4RyfNRDIoLctUgEefZq3r8ZXVuQjxYMfAmhYaCleO9Y/aupmmZXnhl
         X0I53IokWpPZW6BqHiTyLVSxXdIqm6BrNSWktzKdjqkDDeMJCsJGHYsPOIyoPWDDGi54
         nBxa1L2xaJKwbpN7K1N9v0jV3cqey06dxQVUhBgc4w5wSLk3z4aFuLUmguduhpFHscy6
         RfK98k9yVVGpGOTKgILjcLDrnqIao6rFKbVSAqvFFmsiXrSyur0tHq19Cf46XhYU8hvx
         qKjAVlggWKTfk/j104G+W1LG/aN4+zX3PknBtkVwQ7HP307wiCtai25wftGTShNsn9Ze
         FnWg==
X-Forwarded-Encrypted: i=1; AJvYcCWvZVCp+6yMB3k5t7l7KKYM75B4fzki8Hk/8PImoIIwvOmt7VLnUL0yLqD8aQxE03AzNCxMZR3/cC/xuNvIUIUWeZfFhziu3Ok84SU1
X-Gm-Message-State: AOJu0YxxYKWrrvZBECRzqggDIKJb9f/Iterv+d1eJyIxXq6oHyCOXGea
	blTX0lIlc7rNAd3SfWpHmfstphl2IDmJ+DV7BA+Tar8ZPKo9qWH1IepIH5wMmBDhidOilyyLbtU
	U4ax1u1pt9A8h9JDJGhoyWlENQPbuT+LR26XBChsn6gOxz04Q6D1v2fNPGYlKHQ==
X-Received: by 2002:ac8:7d0c:0:b0:444:eeb8:a82c with SMTP id d75a77b69052e-444eeb8ab90mr27637161cf.36.1719321618445;
        Tue, 25 Jun 2024 06:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmi4BijOA/GY1Hjzeta031jkpO4kZIJ6Dnon5So1dsY0+x+bG5IJxLYSaUSTEqUhdw/nQm5w==
X-Received: by 2002:ac8:7d0c:0:b0:444:eeb8:a82c with SMTP id d75a77b69052e-444eeb8ab90mr27636911cf.36.1719321617905;
        Tue, 25 Jun 2024 06:20:17 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2ba6b39sm54598911cf.55.2024.06.25.06.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:20:17 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:20:15 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Song Chen <chensong_2000@189.cn>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com, 
	rostedt@goodmis.org, john.ogness@linutronix.de, senozhatsky@chromium.org, 
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, williams@redhat.com, 
	jlelli@redhat.com
Subject: Re: a question about how to debug this case in ftrace
Message-ID: <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>

Hey Song,

I'll answer that bit as those were my hacks :P

I _thought_ that doing a ftrace_dump_on_oops + softlockup_panic on the
command line (or similar at runtime) would dump the logs, but that
wasn't working for me and I was in a bit of a rush (and already hacking
the kernel up anyways).

So I ended up doing a sequence like:

    tracing_off();
    ftrace_dump(DUMP_ALL);

in the softlockup code when it was detected. Ideally I wanted to look at
the vmcore and look at the ftrace data in there (since debugging printk
by using printk is a little confusing), but there was a makedumpfile bug
I hit... so I went with the hacky route to prove to myself what was
going on. I think since then that's been resolved. Hope that helps!

Thanks,
Andrew

On Tue, Jun 25, 2024 at 09:36:54AM GMT, Song Chen wrote:
> Hi Derek,
> 
> I am working on a hungtask case, i saw your trace_printk logs go to the same
> output with softlockup warning, It's a smart way to easily build a timeline
> for analysis.
> 
> As far as i know, trace_printk goes to ftrace ring buffer and softlockup
> info goes to dmesg. Could you please let me know how you did that, i marked
> the part i'm interested in below, thanks a lot.
> 
> BR
> 
> Song
> 
> 
> 在 2024/6/18 23:20, Derek Barbosa 写道:
> > lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
> > Bcc:
> > Subject: watchdog BUG: soft lockup - CPU#x stuck for 78s
> > Reply-To:
> > 
> > Hi,
> > 
> > The realtime team at Red Hat has recently backported the latest printk changes
> > present in 6.6-rt stable (HEAD at 20fd4439f644 printk: nbcon: move locked_port flag to
> > struct uart_port) to CentOS Stream 9 for performance improvements and
> > printk-related bugfixes.
> > 
> > Since merging this said code, we've hit an interesting bug during testing,
> > specifically, on larger systems, a softlockup may be reported by the watchdog
> > when there is a heavy amount of printing to tty devices (whether it be through
> > printk, /dev/kmsg, etc).
> > 
> > We have a modicum of reasonable suspicion to believe that nbcon_reacquire, or
> > some other nbcon mechanism *may* be causing such behavior.
> > 
> > Since we've succesfully reproduced this in the Kernel-ARK/Fedora-ELN
> > (osbuild-rt), and linux-rt-devel 6.10.rc4-rt6, we are reporting this bug
> > upstream.
> > 
> > Anyway, here is a more in-depth description, along with some call traces.
> > 
> > Description:
> > 
> > On x86 systems with a large amount of logical cores (nproc ~> 60), a softlockup can
> > be observed with accompanying call trace when a large amount of "printing"
> > activity is taking place.
> > 
> > As shown in the call traces appended below, during some kind of numa
> > balancing/numa_migration after a task_numa_fault --where a set of processess are being migrated/swapped
> > between two CPUs-- there is a busy thread that is being waited on (in the order
> > of seconds), causing a livelock. Additional investigation of collected vmcores
> > by toggling panic on softlockup shows that the waiting thread may be waiting for
> > a thread looping with nbcon_reacquire.
> > 
> > I suspect that some logic within nbcon_context_try_acquire may be a good place
> > to start. My understanding of the code becomes a bit fuzzy here, so apologies
> > in advance for any erroneous statements. As I see it, there may be something
> > happening during migration (or under heavy load) in which nbcon_reacquire() is in
> > a non-migratable or non-preemtible state as it is attempting to regain access to
> > a lost/taken console. It could very well be a situation in which context
> > was forcefully taken from the printing thread.
> > 
> > Alternatively, Andrew Halaney <ahalaney@redhat.com> suspects that it is the loop within
> > nbcon_kthread_func() -- since there is nothing that would yield the task in said
> > loop (cant_migrate()), the migrate code would be essentially waiting forever for
> > the aforementioned loop to "finish". I believe in PREEMPT_RT, there would be a
> > preemption point here. Furthermore, in his investigation, there were signs that the
> > loop was just iterating up until the crash, leaving reason to
> > believe that task would be the culprit.
> > 
> > In fact, with the following diff, we noticed this output:
> > 
> > ```
> > ahalaney@x1gen2nano ~/git/linux-rt-devel (git)-[tags/v6.10-rc4-rt6-rebase] % git diff | cat
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index bb9689f94d30..d716b72bf2f8 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1075,6 +1075,7 @@ static int nbcon_kthread_func(void *__console)
> >        *
> >        * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A
> 


