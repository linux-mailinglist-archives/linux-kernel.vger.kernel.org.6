Return-Path: <linux-kernel+bounces-522114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ADFA3C63B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FE83B4544
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB52144DF;
	Wed, 19 Feb 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avo39MrW"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE4214A61
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986130; cv=none; b=hCLHwoXMgcXUKSg3BFg5DLB53Gge3ng2cnf5itQajQTsEwoYwtVXguEU4pmKRopVf3GfZLs4DMSjYK4+LC+Uddwd0i+F0TWeq0bkweoAGkHbpaRZtQquo8TAC6CfKUCqWoQp2A48oJPO9uyTOog61fUwti8YLgYrnofkA1vlXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986130; c=relaxed/simple;
	bh=wiKA6crcfmssShR/ta8Drn5DX3qFyslaa5mzRdNL4Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcxcQGQFe+WK9RpRNyTDOtvhwO53gfMgTGGeuBRk7RIEpt78E6iuRVRvRd7l3C4M1BgFyPg89fsqA8lBaRgWMESX49wpuTmAc3inbl+TYhKPoenW4cL6OkweqsVY4YhqqCt0tyLb5UrAE23YKw53gB3eF8sfUMF86uI168hzCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=avo39MrW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fa7so71470481fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739986127; x=1740590927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCXULtz+TfbEIUzv+aPcSIYu9fSixmaT70fYxAi2ec0=;
        b=avo39MrWzc8q0rAmZeTE33gdbeDsismoSwOTvFxRT0i/WZkXY5cDStjBn6/v+Q+0Ng
         aS8E76P0505gsG0WO9Hl0vBaRku3TMvP0WItLlBHyfpNK893ggQDc517Cm7CptHN3Lr5
         sM6AnBklNUqNmghhSuy/yKimOeiEzESgyUhawTH3fne/quKEePrCtmAgqY+f8DhaEdtI
         KmXeD25+mlL/R5fokRxZhfXfIpnc3NmXhwkJnIGvugkFQ+wROxLeugGQ0nlBKUwhJX9v
         CgKXj57nPuvI1IGF+pdIJsnkcIyClkw8PDvB37ENYdcSSy7nPoMiWLVXoyLgHOM7+Z9C
         xXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986127; x=1740590927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCXULtz+TfbEIUzv+aPcSIYu9fSixmaT70fYxAi2ec0=;
        b=jdNllfxbxDLNBBaAQROjBjuboSdHsAmmIc2HPKycLAd3x7p7NuVr9N3WC0PtszJYyV
         Gbs//xCd83oQ0OY6m4+Tq87o7WZqtLaLE/wpoHuiAMymkCGdTLzSs8547JgUR9guSrCm
         yz8eq88QdF9oDNkQQ3MJzeFW7+G6dLeKHwUt1b+HPVXkFLbSD6tkBzL5sURI/E2Hw9s+
         orgG2nlkl1zchPWDB9MVWYbPcA8m15/05DeeRIDgM6cGA0rFLsEfH5Ej9/pFsSfOHnDP
         KEiBWzPSUU+cSQf8B+xw6QEAV5QIQsUOPBN8MnCU0HTBCHs/7A1hFU1DcP6rspzvjKlE
         jzGg==
X-Forwarded-Encrypted: i=1; AJvYcCXtxcIox/0UP/aE2w6g5pBroyUWiELogADQQdLd5h+n8mqmanR1MxkEfz9TZPMNyH/Z0OxZOM9DmtImVmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCFBNEY3ChxIwjBwdQeWsbmy95KhzBmMJiyhoqt14LszU+8NI
	4SAoJxEyvWpVUM93li6OJmfx9EkUCaFJGfKhGx0ALU4zSHZHon2pCZIDTfiQDnc=
X-Gm-Gg: ASbGncvvBtkOm8EEGA1TlOAZ9ubRSJp7eEVF16xLj6EFozfxSVEzT3Po2JiSPCL5qVF
	aRAcRs2Phd0YQGAB0UqgVgQZ0cMjn3FXlYCQOTDRn4XJd2a0LKLPEBh5Quqq5CkSFep/xGLXo4j
	lsK7KXh7kELlsq8a6CXzoKvVV/tRRL2HSMN6TD0aWWqwdf6vZdl4KEwG+UbUCpfcdJ6sJcAjk5N
	Y97mVY2Eo7SBVPXJ5eJvodFlzkyED5hIdQisJZ7hZVFXnei1QWJH+nYHtMvhVnni0D1rDQeNse2
	Or52hO4Zp7u5CiZuf/Od0bUBzF2TwGKae745uNcOGkTo+ixOFULA9gMDDp655BZNYwoXcU4=
X-Google-Smtp-Source: AGHT+IESuJWqXNXUiZl0M/R+WM8qXHx9smX+DwiL2S6QGonn1pTBFk2AxnVmvzXppPQRcAtEABXWIw==
X-Received: by 2002:a2e:9b0c:0:b0:309:20b4:b6d5 with SMTP id 38308e7fff4ca-30a4502608bmr15251471fa.28.1739986127105;
        Wed, 19 Feb 2025 09:28:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309216aa863sm19168511fa.98.2025.02.19.09.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:28:45 -0800 (PST)
Date: Wed, 19 Feb 2025 19:28:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Vishal Sagar <vishal.sagar@amd.com>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 06/11] drm/fourcc: Add DRM_FORMAT_XVUY2101010
Message-ID: <gkqq3c6pew5etfmjqqzgxtddlu7h3tbscrijkbymls524vfrrz@uy7qysfecrjk>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
 <20250212-xilinx-formats-v3-6-90d0fe106995@ideasonboard.com>
 <bdpw2g65uor77tijlhpabodog7haqvdcemnr3wzqkooerzuib5@hfdn5zsrbkgg>
 <7674314f-d95a-433a-81d2-ca78bc199359@ideasonboard.com>
 <naw67daoyb2lfmq4jovlwanz5niaolptwnug3c3kkrtlfoh6dd@trkctqyzvtb5>
 <23e71045-1ae2-4e02-9780-aa11a338d481@ideasonboard.com>
 <20250219150840.GA31825@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219150840.GA31825@pendragon.ideasonboard.com>

On Wed, Feb 19, 2025 at 05:08:40PM +0200, Laurent Pinchart wrote:
> On Wed, Feb 19, 2025 at 04:47:26PM +0200, Tomi Valkeinen wrote:
> > Hi,
> > 
> > On 18/02/2025 05:26, Dmitry Baryshkov wrote:
> > > On Mon, Feb 17, 2025 at 10:27:56PM +0200, Tomi Valkeinen wrote:
> > >> Hi,
> > >>
> > >> On 17/02/2025 22:15, Dmitry Baryshkov wrote:
> > >>> On Wed, Feb 12, 2025 at 04:56:10PM +0200, Tomi Valkeinen wrote:
> > >>>> Add XVUY2101010, a 10 bits per component YCbCr format in a 32 bit
> > >>>> container.
> > >>>
> > >>> Is there a more common name for this format? Otherwise googling for it
> > >>> reveals only your series.
> > >>
> > >> In the cover letter I mention the gstreamer names where available (this
> > >> particular format is not in gstreamer). AMD has these in their zynqmp
> > >> documentation (https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/Video-Packer-Format).
> > >>
> > >> XVUY2101010 is YUV444_10BPC in AMD docs.
> > >>
> > >> X403 is Y444_10LE32 in gstreamer, and YV24_10BPC in AMD docs.
> > >>
> > >> I'm not sure you'll have much more luck googling with those names, though
> > >> =).
> > > 
> > > I'm asking, because include/uapi/drm/drm_fourcc.h has a pretty explicit
> > > waiver: GL, Vulkan or other open standards. Otherwise normal
> > > requirements apply and it's required to have an open-source usespace
> > > implementation, etc.
> > 
> > I can drop DRM_FORMAT_XVUY2101010 until we get it to gstreamer. I just 
> > had it ready, so I thought it's better to include it than leave out.
> > 
> > Is the current gstreamer support enough for the other formats to fulfill 
> > the userspace requirement?
> 
> We've received a green light in the past to add formats to drm_fourcc.h
> that would be used by cameras only. There's no open formal standard there, but
> we have libcamera as a de-facto standard. I would assume GStreamer to be
> enough for a scanout format.

Thanks for the clarification!

-- 
With best wishes
Dmitry

