Return-Path: <linux-kernel+bounces-543368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F58A4D4BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258453B1D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1D1F7580;
	Tue,  4 Mar 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKTySE8G"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1C1F584E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072658; cv=none; b=gA7YzWEotWDjTShGVaiDX8Lkb4SXfNJqYn0g8K/0cZjaScqEEfROXqVQvgODfSzixdgDPCTQD2ukOF5dho7N/7CfcCZDtZJiUxq/y0AS/ALr/BT7Zu/AqxO87+7N8Jag4etsAWYwKn1jMhi/hb9/md/VMOKy1QvacCgDo7dYYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072658; c=relaxed/simple;
	bh=Xn7fKaMshzmJYk4NxG4ovaPx1f0+bKgREmHnPIdNzAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRqX/pfc62v6aRdbPDoX425mwGdz2+EQZbsoeZMgiFaU1WxDSnFDBzg7Uipb+YgcfN958Bd6B518qIcdxi9q4SmSuq3p8+j1XbMq/6Vg9kQZmar9Fb27MPVyKaDb6CghwYL3oTi0iDKtxJwPHLAZiTqg1KAAGHebhVnxcyV/Zeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKTySE8G; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60009c5dc26so1134374eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741072656; x=1741677456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzHbHM5F2Rwe7GWQtoT/vBL3j3IgEpxjxlyoiFn8SsI=;
        b=iKTySE8Gg5awL0xTgob3uQPfNT7UhpGMpPpkziy/OkFezFcBb+7FvP3B6V+VV/51Ly
         RnZN+Oe7a6ot+i4o4SQFGOTIbrAYy52Do9EDtJamRGmWS6CmBFSRz95D2XFud5uqaKpQ
         +Mywxf5PI7pxiX2X4WT8/jmmS6H6lhRg7ad5JFfBfpvPlhWDphGZIWCh1YfU11c2n0bL
         V8erxVRIP6EJtmlWEcrnVA+OGQHh30J93W3woFmk9AKctfptgx8vb0ldJAa8kkUhFMMp
         e2pmSBiFwlt1Wwp3lE9/KCMyglkK1DR1p1RQT2nvBZmC+hRzPFbGo+0LhqS7N1ouOINA
         r50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741072656; x=1741677456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzHbHM5F2Rwe7GWQtoT/vBL3j3IgEpxjxlyoiFn8SsI=;
        b=hcVDy+21/sKPPBNxCPXJCwEeBgDCSYIXzKoBiarCLW8A0avAeYjTuPtUJIyN4G9X6y
         VKpsfUsWuCBEpqNWiaKaobDrvGLBrB6yvz1CA+b4zbCZ8bwqKDf8j+n2DtkyIsUc1MrN
         XaKUK3rO3SbRs4zmRMT9MtAqhZg8HHOCmCPcpuOcLzs9IqBGQkNQEMFtdKWQbyNXDVWt
         N4R3UKo9NPfQunOA50W2XwWUAlAM2Gu8Nlb2KdasSWalLMDRyC3rq4Jyw8t8CLOBx0PI
         hDay7S09JBNXF7F86jBHjW72gtOb0RSpMxZOOHHI1umJSr+huqvBs9E3tRsTjpf6n2O9
         02VA==
X-Forwarded-Encrypted: i=1; AJvYcCUCqFT6kXbZEBtvgB2VGTioK2mwfCQ209MQg95LerF8Lyyp6+e22j6YGtT2Y8A99qBN/+DZxJMzvj8d+MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZwIlI14mqYfIxOjldxr3+HGWEL5Rz9ydiZRJCqNtCQ70Tj2B
	LK4IUAsQ2bee/DrIXOTgLzab/zKtF2g7D5gN1Kh0vCgxrPahH4U/07LqCMUsfwTOco0CiV7azxK
	ABZ6DwNPUwHDSb9UYAtfbwSIkW3oSMbvISQL+XQ==
X-Gm-Gg: ASbGncvS+QydZ5w9WyODgox9xUJV+II2yvyhC+OiDRHKPsRFyyVs+VyRZNUR/uaMS7o
	bVTSkBG9NhlgNX4eJSpwBt45RZk20UXwS/KGq49dH3ufzVJaR2KYmoiG23fEWhaq9r/XaljtSij
	jfgM2+JuK8wvFedB7o7WBhjLU0e1A=
X-Google-Smtp-Source: AGHT+IGeWth+Ec7HvnFz4HF064DwKqNeMXOfgif6GoecOEfs8x2Q7Fc7PxDdZ1yzepEKq7Z5LS0hsWXFxueHCzU4cFY=
X-Received: by 2002:a05:6820:2217:b0:5fc:e323:785e with SMTP id
 006d021491bc7-5feb360c2c2mr8620716eaf.5.1741072655731; Mon, 03 Mar 2025
 23:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217100809.3962439-1-jens.wiklander@linaro.org>
 <20250212205613.4400a888@collabora.com> <CAFA6WYOaGEPj0xNEDBCoEmjJreEHChjQ2hyXRJ_CYoGhiBonfw@mail.gmail.com>
 <20250213093557.278f5d19@collabora.com> <CAFA6WYOJkSRsH-15QdqXNMd08Q=Dg4NkRd1Cr9LXA+5nozTF6g@mail.gmail.com>
 <20250213134008.4cbef142@collabora.com> <CAPj87rM5Y=-Jgf4mwukicF6Yb-vccn2fpG2X1jNq0upH2+cAEQ@mail.gmail.com>
 <CAHUa44G9hw-z6wzxg=HkVAxPKEW1yES5JTEqRWMvJUJAtcUDkQ@mail.gmail.com>
 <CAPj87rPHnME5Osgnf5-FSAu22mDpLj=dzvhi_NqEcOwr1ThgGw@mail.gmail.com>
 <CAHUa44Gs0D1fBD0=+EDgcQUMeDv4knci9trUkYEc1J98qFV7HQ@mail.gmail.com>
 <CAFA6WYOuTwRPEh3L7+hMyARB_E73xmp+OwhKyS-r4+ryS7=9sw@mail.gmail.com>
 <20250214164856.0d2ead8a@collabora.com> <CAFA6WYPc6EHQwcPuMZRm4C1P6SoDrCzEPUmju_meupB6NXQ1sg@mail.gmail.com>
 <CAPj87rN-OYTzh5=Gdv619UQD5=x=U6Yt=uV4N1kCs4Zao4RVAg@mail.gmail.com>
 <CAFA6WYMLLLSuz3y5J+DuRFAGrmwpZoWax5sasfAUhXoQXmrNNA@mail.gmail.com> <CAPj87rN7J6u9NsviAdw8=OenEYc8t719Lds6u6-BhFKrtkLZ-A@mail.gmail.com>
In-Reply-To: <CAPj87rN7J6u9NsviAdw8=OenEYc8t719Lds6u6-BhFKrtkLZ-A@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 4 Mar 2025 08:17:23 +0100
X-Gm-Features: AQ5f1JrEtCh2L2kJC0WD3IbY9SZ2HYIAKqjRP2-ff7KQiuotp3pduZ0dOaK3kQU
Message-ID: <CAHUa44FkG1NAWpoW8UVBywv44XW_mjAJa32PcC9mcmiOLdiRqw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
To: Daniel Stone <daniel@fooishbar.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	"moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Florent Tomasin <florent.tomasin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, Feb 21, 2025 at 3:12=E2=80=AFPM Daniel Stone <daniel@fooishbar.org>=
 wrote:
>
> Hi Sumit,
>
> On Fri, 21 Feb 2025 at 11:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> > On Tue, 18 Feb 2025 at 21:52, Daniel Stone <daniel@fooishbar.org> wrote=
:
> > > dma-heaps was created to solve the problem of having too many
> > > 'allocate $n bytes from $specialplace' uAPIs. The proliferation was
> > > painful and making it difficult for userspace to do what it needed to
> > > do. Userspace doesn't _yet_ make full use of it, but the solution is
> > > to make userspace make full use of it, not to go create entirely
> > > separate allocation paths for unclear reasons.
> > >
> > > Besides, I'm writing this from a platform that implements SVP not via
> > > TEE. I've worked on platforms which implement SVP without any TEE,
> > > where the TEE implementation would be at best a no-op stub, and at
> > > worst flat-out impossible.
> >
> > Can you elaborate the non-TEE use-case for Secure Video Path (SVP) a
> > bit more? As to how the protected/encrypted media content pipeline
> > works? Which architecture support does your use-case require? Is there
> > any higher privileged level firmware interaction required to perform
> > media content decryption into restricted memory? Do you plan to
> > upstream corresponding support in near future?
>
> You can see the MTK SVP patches on list which use the MTK SMC to mediate =
it.
>
> There are TI Jacinto platforms which implement a 'secure' area
> configured statically by (IIRC) BL2, with static permissions defined
> for each AXI endpoint, e.g. CPU write + codec RW + dispc read. I've
> heard of another SoC vendor doing the same, but I don't think I can
> share those details. There is no TEE interaction.
>
> I'm writing this message from an AMD laptop which implements
> restricted content paths outside of TEE. I don't have the full picture
> of how SVP is implemented on AMD systems, but I do know that I don't
> have any TEE devices exposed.
>
> > Let me try to elaborate on the Secure Video Path (SVP) flow requiring
> > a TEE implementation (in general terms a higher privileged firmware
> > managing the pipeline as the kernel/user-space has no access
> > permissions to the plain text media content):
> >
> > - [...]
>
> Yeah, I totally understand the TEE usecase. I think that TEE is a good
> design to implement this. I think that TEE should be used for SVP
> where it makes sense.
>
> Please understand that I am _not_ arguing that no-one should use TEE for =
SVP!
>
> > > So, again, let's
> > > please turn this around: _why_ TEE? Who benefits from exposing this a=
s
> > > completely separate to the more generic uAPI that we specifically
> > > designed to handle things like this?
> >
> > The bridging between DMA heaps and TEE would still require user-space
> > to perform an IOCTL into TEE to register the DMA-bufs as you can see
> > here [1]. Then it will rather be two handles for user-space to manage.
>
> Yes, the decoder would need to do this. That's common though: if you
> want to share a buffer between V4L2 and DRM, you have three handles:
> the V4L2 buffer handle, the DRM GEM handle, and the dmabuf you use to
> bridge the two.
>
> > Similarly during restricted memory allocation/free we need another
> > glue layer under DMA heaps to TEE subsystem.
>
> Yep.
>
> > The reason is simply which has been iterated over many times in the
> > past threads that:
> >
> >     "If user-space has to interact with a TEE device for SVP use-case
> > then why it's not better to ask TEE to allocate restricted DMA-bufs
> > too"
>
> The first word in your proposition is load-bearing.
>
> Build out the usecase a little more here. You have a DRMed video
> stream coming in, which you need to decode (involving TEE for this
> usecase). You get a dmabuf handle to the decoded frame. You need to
> pass the dmabuf across to the Wayland compositor. The compositor needs
> to pass it to EGL/Vulkan to import and do composition, which in turn
> passes it to the GPU DRM driver. The output of the composition is in
> turn shared between the GPU DRM driver and the separate KMS DRM
> driver, with the involvement of GBM.
>
> For the platforms I'm interested in, the GPU DRM driver needs to
> switch into protected mode, which has no involvement at all with TEE -
> it's architecturally impossible to have TEE involved without moving
> most of the GPU driver into TEE and destroying performance. The
> display hardware also needs to engage protected mode, which again has
> no involvement with TEE and again would need to have half the driver
> moved into TEE for no benefit in order to do so. The Wayland
> compositor also has no interest in TEE: it tells the GPU DRM driver
> about the protected status of its buffers, and that's it.
>
> What these components _are_ opinionated about, is the way buffers are
> allocated and managed. We built out dmabuf modifiers for this usecase,
> and we have a good negotiation protocol around that. We also really
> care about buffer placement in some usecases - e.g. some display/codec
> hardware requires buffers to be sourced from contiguous memory, other
> hardware needs to know that when it shares buffers with another
> device, it needs to place the buffers outside of inaccessible/slow
> local RAM. So we built out dma-heaps, so every part of the component
> in the stack can communicate their buffer-placement needs in the same
> way as we do modifiers, and negotiate an acceptable allocation.
>
> That's my starting point for this discussion. We have a mechanism to
> deal with the fact that buffers need to be shared between different IP
> blocks which have their own constraints on buffer placement, avoiding
> the current problem of having every subsystem reinvent their own
> allocation uAPI which was burying us in impedance mismatch and
> confusion. That mechanism is dma-heaps. It seems like your starting
> point from this discussion is that you've implemented a TEE-centric
> design for SVP, and so all of userspace should bypass our existing
> cross-subsystem special-purpose allocation mechanism, and write
> specifically to one implementation. I believe that is a massive step
> backwards and an immediate introduction of technical debt.
>
> Again, having an implementation of SVP via TEE makes a huge amount of
> sense. Having _most_ SVP implementations via TEE still makes a lot of
> sense. Having _all_ SVP implementations eventually be via TEE would
> still make sense. But even if we were at that point - which we aren't
> - it still doesn't justify telling userspace 'use the generic dma-heap
> uAPI for every device-specific allocation constraint, apart from SVP
> which has a completely different way to allocate some bytes'.

I must admit that I don't see how this makes a significant difference,
but then I haven't hacked much in the stacks you're talking about, so
I'm going to take your word for it.

I've experimented with providing a dma-heap replacing the TEE API. The
implementation is more complex than I first anticipated, adding about
400 lines to the patch set. From user space, it looks like another
dma-heap. I'm using the names you gave earlier,
protected,secure-video, protected,trusted-ui, and
protected,secure-video-record. However, I wonder if we shouldn't use
"restricted" instead of "protected" since we had agreed to call it
restricted memory earlier.

I'll soon post this in a v6 and an updated demo.

Cheers,
Jens

