Return-Path: <linux-kernel+bounces-388263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2269B5CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8071C20FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457F1DE898;
	Wed, 30 Oct 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4k24YWj"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCE85931
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273062; cv=none; b=U1CYYI7BVqeqqIhfLe3tek8Gmmj/4zZPKtNqOoikMTe8RU+mBFcDxt9L/QBvLsryLHpPJbV3UOUTY/lUUm3CLBlC0CCp62looPokDTMiHi0D799KZKzRhdVJ9mnAMivSTHckngjpjtPeZcfrOycLhmuZbzloHYTIJ24llmwQIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273062; c=relaxed/simple;
	bh=04Q1jGOylYIJlE4+xxIqfIKlz4SH9/54YIwYenDZjKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8J9X8c5qOmmCbRY1D7OPHr1nosr0meF42m8A6dO4GJlSr54+lOPwaz7/NTY5djZ+F+f84NqdIrjCi2zUBNCbX2A2cFgut3ce49YZG0knADMMR26TFUUwHwfqeAlMfmEPNnoAQKhgQ7HXkwaylb3GSpaEWbJWfKJP/fmk3xX6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4k24YWj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso5143879a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730273058; x=1730877858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbT1k0jtYtZoc6ycNC6ItDSMfqtmx2QXiTFNjmf6lrE=;
        b=P4k24YWj5Rl289vSOKssybjdj+EAjNZ+hIFrrDvxSlX/rwCWJmnBNc4kzZfJ/4xf53
         9hP1f9XV6k6xr4Cef1L6q65qvbbj8U4mm1mIWlaxeriBEIq2v0FHYg0HdGTOdCz7Bm8u
         u7AfwCUoIT0ilYJiNNOg4mZ5AsGoyKYJ+QmlTbk8HOf5RE7loE1WKZo1YfFGa2Dw6ZGj
         B+67w8f1eH/ikQsGH49oMKq8dK2gtWtF/lJPr0TYOEdYMSPEfgHGN6I5CUME9J6kZm4f
         OqBEvdawpCAbGz5vTrY6Ej2iYPg3dIC6ZRGwJpp0ZK88ypQVwacj26+MZssj/VpS3lmt
         ieLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730273058; x=1730877858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbT1k0jtYtZoc6ycNC6ItDSMfqtmx2QXiTFNjmf6lrE=;
        b=sUQhqCSMjgGjaS2XXOMwDtFlptcFJfnDZBElmwTNCLVDlkUx4RCKkUE7ZBJ1o0nxgY
         3dqlhUxBoWLDRd7V8aeLsup9EhaMU2dCrV/YTnK9/ibGNEzJzDhqyqGCWibvzeKBJOCd
         gztn2C4K2H4zBwzjpYjw2gifawRd2QL9qWFT1zwpMy/sf+MP+E7/RPnJW4xoY/Bkbtzv
         PkLLlCNWz9Vij2TFTCYKPNmdf6cZ2J89o3YX5LhMjs3w1XMd6HXtMslgAznq5mvNX5HU
         Uy1PFGpiEfLiNyNbwXqK+BBW2UwyCTwza5nCSq1dACfXwFypJhv1P7L0O7dKBPqmnbt4
         E5nA==
X-Forwarded-Encrypted: i=1; AJvYcCUawIOhtcoddKyR0Mka4UY6nJKtungr4ZIfPwNW44GQFCdS2mdDiBxfp54mz8Al9Auc1KufLodqyzHOiiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+SMpVW4PMo112iAIb3pOYqKU96IQ9qhpE+wuypyf7s6nrBK6
	cEqWBNy6i8c0mirqVeqYx6aTmrSjdK+GpZY+9jvrAACMK5wAO7YO
X-Google-Smtp-Source: AGHT+IGM+v6NAXeMP4IkNaKUigE2nCoiG2YAIRRjbeoigodmsy8+M4z+pI/60s/KOdi65Cr7EMZExQ==
X-Received: by 2002:a17:90b:360a:b0:2e2:cef9:4d98 with SMTP id 98e67ed59e1d1-2e8f10a7281mr14965333a91.25.1730273058404;
        Wed, 30 Oct 2024 00:24:18 -0700 (PDT)
Received: from [10.3.80.76] ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa76aa6sm935500a91.36.2024.10.30.00.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 00:24:18 -0700 (PDT)
Message-ID: <c389ea3e-70cb-46c5-8cf1-878a99f771ec@gmail.com>
Date: Wed, 30 Oct 2024 12:54:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: leadtek-ltk050h3146w: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241026035928.183454-1-tejasvipin76@gmail.com>
 <CAD=FV=Vps5vWD72O_kYhuKudduYed41+tZrVRB6x+FiaZrm-EA@mail.gmail.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <CAD=FV=Vps5vWD72O_kYhuKudduYed41+tZrVRB6x+FiaZrm-EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/24 12:24 AM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 25, 2024 at 9:00 PM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> @@ -418,79 +398,42 @@ static const struct ltk050h3146w_desc ltk050h3146w_data = {
>>                 MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
>>  };
>>
>> -static int ltk050h3146w_a2_select_page(struct ltk050h3146w *ctx, int page)
>> +static void ltk050h3146w_a2_select_page(struct mipi_dsi_multi_context *dsi_ctx, int page)
>>  {
>> -       struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>> -       u8 d[3] = { 0x98, 0x81, page };
>> +       u8 d[4] = { 0xff, 0x98, 0x81, page };
>>
>> -       return mipi_dsi_dcs_write(dsi, 0xff, d, ARRAY_SIZE(d));
>> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, d, ARRAY_SIZE(d));
> 
> FWIW: the above might be slightly better as:
> 
> mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x98, 0x81, page);
> 
> That would make it more documenting that the 0xff is the "cmd", has
> fewer lines of code, and also gets the array marked as "static const"
> which might make the compiler slightly more efficient. ;-)
> 
> Not really a huge deal, though.
>

I did try this initially, but got an error because of page not being a
compile time constant. Not sure how I should handle this.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

-- 
Tejas Vipin

