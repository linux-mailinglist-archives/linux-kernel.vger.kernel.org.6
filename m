Return-Path: <linux-kernel+bounces-337627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F5984CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0692855DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E42913C69E;
	Tue, 24 Sep 2024 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTUdorwk"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E9139D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212644; cv=none; b=Y4HrwxI1Iexg8m+gXxtd1jT/LK2WptIt9d24zFfy9AQ+tg0/WGjzhJXGMtpkeK5pj/FDej9H/z/q6TznSFiA3nHSLlJclRoxY4lubVxpcDZYDG6P94vA2uJu5M8/wSL+BLNFkrS00GcOzimsr105BDrQMahq8ZuekggojvRik3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212644; c=relaxed/simple;
	bh=kY5B1lKQE6VDB0/CjqQ/eBADRPELBS0FbJT42ldOlAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7UXDJNCzNJmGBrIm1ZyMXYaLK5SeeA/u7NsI7XGhwEx0a9lGi7PPc8f48deV2kZj38upfXUQen7W60TS641aRUJNOx43uuVk7JmR65Kt8xZYfMf4CemTlXaZF/PLRt3toaBVXXWVyn+SDfeES8QCLM7IAWpk4tz6bzMbGfvmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sTUdorwk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so4084441a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727212642; x=1727817442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SY8FfHt16U5m6B6pNiUvGeoZtkNdoLUQsMWA2KdXlPs=;
        b=sTUdorwkqcbtyZb0E2QKyChd7nTOyZnli3VHthjWf3seWuK238CXgIpxb3X9MySfjW
         KZYEVdMwwNt8f4xoS7+TzFcSQ2BvXPJ9zFJBvEHi9x13DHbUqvEBrLKjcKkJmBjKGnm9
         QHdg3rM8KAZeLAPZgFvsx4hX1+3nP2Oy7DVQnH5OV6iLEG+lU9MtciPPktP/pVIdAc/x
         2KICKpT/lD/4tB1BG7T+7I4tHIN3IJNbK8Ibfkdceext7ZELLlMJs76MvVIkVU5VlGAk
         SsXfvp991T4DaduapyUshGKAsftXfAbkEjjVfelARIo0H1OUMim9Z+U92uH79E38lftw
         dXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212642; x=1727817442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY8FfHt16U5m6B6pNiUvGeoZtkNdoLUQsMWA2KdXlPs=;
        b=nzfb+TioqvrEXalUfvv5YlWTe7I7j9xSEzMxWHumt85rbBMaVvI495PV5c30CZtv/1
         ZR0Eg2if60R2IR34lgtorVbemPEhPmd8z9gNv7X3equXLOpPFT9UCsmsPIKoFEdpRQy2
         g+0R5TJCPA60CMJY2bIbtl5QFjHywmo+wteYgciqf09TKjxrPpUDEKGcB1I3Mxu2QIWf
         RtGuWeNW/2F9FgWYrQJevOGWUw0dJwUTB2mkhn6p+6yy0TcXcayyGS/lNkO71IxxAgcq
         J9g6tfRnVzPtlGVrM0KC5iEg76GXNR6UqGd+LYECEiZkNW4rlI5tJjZ/ziL6DNkcmQPW
         8TLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWps8TBOzxIbp9z9NQdj7tfvqzT7Yg5LiI1jwlixTtv5bZwWRcPExb4RsjmxtDuG7MUghg3qKuYD8AzXJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEOPHuDSQb3+1ip8J5ZvORUuX7u580g3tuTwXD9Mo6DIQn55A
	SYeQL+SdbtNbCI6XFF0jlF4gewttQE0tO2e2l/lva1pTXs7jD9rKHTEq9V0SfVI=
X-Google-Smtp-Source: AGHT+IELxgQZ858P/rlz+GrG0mmGJ5tEs0eoUOeNbDhqhO5P0mDTLtOImdBCwEESWkdyt0obLmKy3g==
X-Received: by 2002:a05:6a20:2d26:b0:1d4:4a69:a0dc with SMTP id adf61e73a8af0-1d4d4b9ba0cmr670881637.33.1727212642344;
        Tue, 24 Sep 2024 14:17:22 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3e2a:4015:f497:ecf2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc83465asm1578248b3a.40.2024.09.24.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:17:21 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:17:18 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Martyn Welch <martyn.welch@collabora.com>,
	Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Beleswar Padhi <b-padhi@ti.com>,
	Zhang Zekun <zhangzekun11@huawei.com>,
	Naina Mehta <quic_nainmeht@quicinc.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>, Tanmay Shah <tanmay.shah@amd.com>,
	Tengfei Fan <quic_tengfan@quicinc.com>,
	Udit Kumar <u-kumar1@ti.com>
Subject: Re: [GIT PULL] remoteproc updates for v6.12
Message-ID: <ZvMsXv5N3iVTzjKn@p14s>
References: <20240924044741.3078097-1-andersson@kernel.org>
 <CAHk-=wieXpmx=+gEuhQSEEZLyQHFLDk5=59j0OtOF==mQdVjYA@mail.gmail.com>
 <CAHk-=wgMBWsDkuQvZYfLj=rvQDnN4rdseS-LkR_VwD+xzvjjiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMBWsDkuQvZYfLj=rvQDnN4rdseS-LkR_VwD+xzvjjiA@mail.gmail.com>

On Tue, Sep 24, 2024 at 12:52:42PM -0700, Linus Torvalds wrote:
> On Tue, 24 Sept 2024 at 12:31, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It's in my tree now, but please fix asap.
> 
> Argh, now that I noticed it, I can no longer unsee it.
> 
> So I did this
> 
> -       depends on ARCH_K3 || COMPILE_TEST
> +       depends on ARCH_OMAP2PLUS || ARCH_K3
>

Thank you for doing this and apologies for the late reply.

Mathieu

> to the TI_K3_M4_REMOTEPROC entry so that it wouldn't try to select
> OMAP2PLUS_MBOX in conditions where it isn't valid.
> 
>                 Linus

