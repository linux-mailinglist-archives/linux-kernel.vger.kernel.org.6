Return-Path: <linux-kernel+bounces-327600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4733597783C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93445B23D06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95C1448ED;
	Fri, 13 Sep 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1X8puXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FEF3EA64
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726204831; cv=none; b=oaRmDXekBQmB/XV+LjPr/Ui/E2uAFzHVViW1Q06h6uFG61AhCUBTXELMWLVfsrhp4mumitQXdPA9fjnvhIbC87gaDJJzTSZ5p9lmk/H0F99yMP/FsxXQTBXE3kOUCQrq1svCa+/YL9I5Aa7ddo27GQ7Z7sJuLT3QFk3QT/fjD5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726204831; c=relaxed/simple;
	bh=UaW0JClroVNWlhraitr91hMTlbi5VT0vYCxxVYhROnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYb/VtZBErYwNHo466yboqYQRrxNsHDb97ZWkmVmMswfcqLT9mMctJIUP1hAVa4zl+kf4nvNdlpPbgmIKLwHYnLdvbfYwB4WwgDKODZ1rgVNfTNh093zYugpa8jDVNxkcUEAEEqgOqyPxl6uALb2K30taQYNcmFEH3yjk/HQRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1X8puXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABACC4CEC0;
	Fri, 13 Sep 2024 05:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726204830;
	bh=UaW0JClroVNWlhraitr91hMTlbi5VT0vYCxxVYhROnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1X8puXt78CFZ0KTOxYWbbedI3hRAEt2J3hDaWmopuqbnbJ4pltPhCkxPeMZVdlAO
	 8FkDicu+y551u5INo+El52K7j8OovI23sX0C+5g4s8dFUJJyS5Ihp0d3xWO1ccXWBJ
	 N3Adh0sZvGNO9etM5F5Qr54FPMctVKYvrDdzmkukRild/lorPTAd/3D0oZc9g7jas0
	 bCVWHYXZ21GIjd0d0ixvYlo6xYWuKdxFLP0lr7j6xb/2pfim+xB9cMi0cj/y6Cg3HW
	 tzxWNJ39Bo6JHM1bCGAiXmQZjW9i7J3xssFVbu8f70T4/xKIpb8RJ0B2XmITT37zqv
	 zgew5k9QjyaDg==
Date: Fri, 13 Sep 2024 07:20:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240913072025.76a329b0@foz.lan>
In-Reply-To: <20240912144233.675d6b63@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
	<20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
	<20240825052923.715f88bc@sal.lan>
	<20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
	<20240911163436.00004738@Huawei.com>
	<20240912144233.675d6b63@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 12 Sep 2024 14:42:33 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 11 Sep 2024 16:34:36 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 11 Sep 2024 15:21:32 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > > On Sun, 25 Aug 2024 05:29:23 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >   
> > > > Em Mon, 19 Aug 2024 14:51:36 +0200
> > > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > > >     
> > > > > > +        read_ack = 1;
> > > > > > +        cpu_physical_memory_write(read_ack_start_addr,
> > > > > > +                                  &read_ack, (uint64_t));        
> > > > > we don't do this for SEV so, why are you setting it to 1 here?    

The diffstat doesn't really help here. The full code is:

    /* zero means OSPM does not acknowledge the error */
    if (!read_ack) {
        error_setg(errp,
                   "Last CPER record was not acknowledged yet");
        read_ack = 1;
        cpu_physical_memory_write(read_ack_start_addr,
                                  &read_ack, sizeof(read_ack));
        return;
    }

> > > what you are doing here by setting read_ack = 1,
> > > is making ack on behalf of OSPM when OSPM haven't handled existing error yet.
> > > 
> > > Essentially making HW/FW do the job of OSPM. That looks wrong to me.
> > > From HW/FW side read_ack register should be thought as read-only.  
> > 
> > It's not read-only because HW/FW has to clear it so that HW/FW can detect
> > when the OSPM next writes it.
> 
> By readonly, I've meant that hw shall not do above mentioned write
> (bad phrasing on my side).

The above code is actually an error handling condition: if for some
reason errors are triggered too fast, there's a bug on QEMU or there is
a bug at the OSPM, an error message is raised and the logic resets the 
record to a sane state. So, on a next error, OSPM will get it.

As described at https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html?highlight=asynchronous#generic-hardware-error-source:

   "Some platforms may describe multiple Generic Hardware Error Source
    structures with different notification types, as defined in 
    Table 18.10. For example, a platform may describe one error source
    for the handling of synchronous errors (e.g. MCE or SEA), and a 
    second source for handling asynchronous errors (e.g. SCI or
    External Interrupt)."

Basically, the error logic there seems to fit for the asynchronous
case, detecting if another error happened before OSPM handles the
first one.

IMO, there are a couple of alternatives to handle such case:

1. Keep the code as-is: if this ever happens, an error message will
   be issued. If SEA/MCE gets implemented synchronously on HW/FW/OSPM,
   the above code will never be called;
2. Change the logic to do that only for asynchronous sources
   (currently, only if source ID is QMP);
3. Add a special QMP message to reset the notification ack. Probably
   would use Notification type as an input parameter;
4. Have a much more complex code to implement asynchronous notifications,
   with a queue to receive HEST errors and a separate thread to deliver
   errors to OSPM asynchronously. If we go this way, QMP would be
   returning the number of error messages queued, allowing error injection
   code to know if OSPM has troubles delivering errors;
5. Just return an error code without doing any resets. To me, this is 
   the worse scenario.

I don't like (5), as if something bad happens, there's nothing to be
done.

For QMP error injection (4) seems is overkill. It may be needed in the
future if we end implementing a logic where host OS informs guest about
hardware problems, and such errors use asynchronous notifications.

I would also avoid implementing (3) at least for now, as reporting
such error via QMP seems enough for the QMP usecase.

So, if ok for you, I'll change the code to (2).


> > Agreed this write to 1 looks wrong, but the one a few lines further down (to zero
> > it) is correct.
> 
> yep, hw should clear register.
> It would be better to so on OSPM ACK, but alas we can't intercept that,
> so the next option would be to do that at the time when we add a new error block
> 
> > 
> > My bug a long time back I think.
> > 
> > Jonathan
> > 
> > >   
> > > > 
> > > > IMO, this is needed, independently of the notification mechanism.
> > > > 
> > > > Regards,
> > > > Mauro
> > > >     
> > > 
> > >   
> > 
> 



Thanks,
Mauro

