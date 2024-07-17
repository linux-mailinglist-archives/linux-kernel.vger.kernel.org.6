Return-Path: <linux-kernel+bounces-255412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1637934073
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0112832E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0C181BA2;
	Wed, 17 Jul 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB952U6G"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8166FB9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233861; cv=none; b=IreyDZhzv7nK+vEhPvlUlXJHmgtSKyToIu4yn8fEo+KZAYvXxCfpkKQCFd6sGrpwZP+4z41BWdos9u7nEspRq7glSbTf0MnuwXnj+AjIM162YgnQNjXdQ56c+J5zF2S/axn/VwmZ6iSIpykWPyRTlC+o3kP83PT6zidFTrEIqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233861; c=relaxed/simple;
	bh=nU+9r4Mm3q+d080XAjsGcioPnv0813i4qpKKRyNwTzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmEVTR4mE6wh5XSpS9rgqmn1S/MyMsxnh9eI3OmZfa5xVy0uF9STHhCBtyzlDjoiJHnQNEOPmcx8Vix94Rqrd83lPftTH97qXhKuNZJyhpurcRqkSG3FY5HpT71pie0k6FAdI/qq4FAQoJUfuPZBOBe4JHWNmbGZ8Da4A+Z4I+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lB952U6G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso38164615ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721233860; x=1721838660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZhsh+wnWjt6cLcXDiRXnrrVDVKDoWotCT7UNQJ5Bng=;
        b=lB952U6G6/gIKamCkECj6Mz5b1VWDUUXP0nq72L4BR5dJ6hnkCdAGuwAVO4CU5euRv
         +f56QonWRZJDgxNtVrN6oZVgGv47EtbsYKO5kVe2BmHPiFbQvAqHqMWFgu7r4P9XyZnq
         mD5s4oVirurCjyWugw3weyBwbCAwe1YQ6yplC2GRgxY5X3qJbprtobeE8+7Msvzvll4S
         Lu7UOjSb/O4vruiRUKFz6rNmIs0kVihp7HTXjbXk1qSHJE0bV4DJfRMZ9e0H6SfDHHKC
         fpyF5I1UlFisYR5YXkCPQO/qAX7LHP79oVguJE5hAW8vrOrkBgK85u/XIaaPglzF4iyC
         W0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233860; x=1721838660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZhsh+wnWjt6cLcXDiRXnrrVDVKDoWotCT7UNQJ5Bng=;
        b=iVhmviJTW5+0uMXe80YUMqjLgcFkQDu/uHHVkZ8VnSHTnqEqCmgfQDAeU4t2pivmSL
         VC4vWzOsHDih15C/5NJnafqK4DQMB6WirzWR3v+oBaS0wnbJqswOlwK4EaZiGy5+oaPy
         2gdiy04drd8Pi59/1879IGJDi+CsRmOX5PsGHkL9v39TpYy/dP/lzuXLE9qDfu5RYbCQ
         AeaNdmGgqPX1zlDWlyAVyqkFVI5Bg41NE70Tl5RcFHCvQcdI10lRkaeZh+D961jr2Rv+
         Y/UGhYv7hlZdJ+sNxTSEnxUMkAUkM7rY+YxPwvQIBpA5HP4DF2W9ZKyxOcUP6bb/PT1B
         i9gw==
X-Forwarded-Encrypted: i=1; AJvYcCXDDpBFpUZTQmprUL/wpUwFDTXKn/p5o5QatB4yKYpR5jLLkQc1A3fSeMTCfx4IwOI8qMfQbvQ0DnAq0kf8d97UHX8hEhswR2CDTN8T
X-Gm-Message-State: AOJu0YzkpluFrySojYV/uWf4Oe8ThiwZ008o0l1ArlOAv7rYJsWjetMr
	BHBAIebGJnVacq01uHzpW5bjZUJysYX3Q/Q/uUdNAiltHtIG8SBq
X-Google-Smtp-Source: AGHT+IGxeqX0fUugMvXSq1rVpJvLlkHouZdSRo4dovsKIrcHqbTZYwptDD/VOC3M9svMeLtuDbRMoQ==
X-Received: by 2002:a17:902:6841:b0:1f9:c508:acd5 with SMTP id d9443c01a7336-1fc4e105dcdmr13989135ad.5.1721233859603;
        Wed, 17 Jul 2024 09:30:59 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([117.98.155.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2733asm77343535ad.162.2024.07.17.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 09:30:59 -0700 (PDT)
Date: Wed, 17 Jul 2024 22:00:49 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, harry.wentland@amd.com,
	sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com, christian.koenig@amd.com,
	Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drm: Fix documentation warning for read_mpcc_state in
 mpc.h
Message-ID: <ZpfxuUXAjmPJvLgR@embed-PC.myguest.virtualbox.org>
References: <20240712174510.70467-1-abhishektamboli9@gmail.com>
 <fb2b106e-aa51-4108-9d61-ba71935fba00@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2b106e-aa51-4108-9d61-ba71935fba00@amd.com>

On Mon, Jul 15, 2024 at 05:46:38PM -0400, Aurabindo Pillai wrote:
> 
> 
> On 7/12/24 1:45 PM, Abhishek Tamboli wrote:
> > Add detail description for the read_mpcc_state function in the
> > mpc_funcs struct to resolve the documentation warning.
> > 
> > A kernel-doc warning was addressed:
> > ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning:
> > Function parameter or struct member 'read_mpcc_state' not
> > described in 'mpc_funcs'.
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 16 ++++++++++++++++
> >   1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > index 34a398f23fc6..9e65ecf1d3b0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
> > @@ -282,6 +282,22 @@ struct mpcc_state {
> >    * struct mpc_funcs - funcs
> >    */
> >   struct mpc_funcs {
> > +	/**
> > +	 * @read_mpcc_state:
> > +	 *
> > +	 * Reads the state of a given MPCC instance.
> > +	 *
> > +	 * Parameters:
> > +	 *
> > +	 * - [in/out] mpc - MPC context.
> > +	 * - [in] mpcc_inst - MPCC Instance whose state is to be read.
> > +	 * - [out] mpcc_state - MPCC state structure where the state
> > +	 *                    of the MPCC instance will be stored.
> > +	 *
> > +	 * Return:
> > +	 *
> > +	 * void
> > +	 */
> >   	void (*read_mpcc_state)(
> >   			struct mpc *mpc,
> >   			int mpcc_inst,
> 
> Looks like fix for this has been already merged via a195f08636f9d7
> drm/amd/display: fix documentation warnings for mpc.h
> 
Thanks Aurabindo for pointing this out.

Regards,
Abhishek 	
> --
> 
> Thanks & Regards,
> Aurabindo Pillai

