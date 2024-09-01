Return-Path: <linux-kernel+bounces-310068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB61696745C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7834280C82
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA12C6B6;
	Sun,  1 Sep 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zv3xNt67"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5B1E87B
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160442; cv=none; b=X0j9Evcz8w8GzW4BW9irxljsxSU4Z5xYAaaUrzWt7oWqTlN/1vzIAZ/u4Ran/xxPkF4v8Dj5WDFbYWHX+G1tojPP4NnHz5ndCL9Bq9g+S3E2epFZt+5zDdiuYVBfYOA/LTOulTxa3yRpry3pOXWdTBug7DaWkKTYYWV90ff6kgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160442; c=relaxed/simple;
	bh=YWMWPcMqHWLz5765/EzioozPxEQli1yw5/WJvX7GxB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkyheBsJQnMnKTSBVIKnJkQcTjbgs5CDvRgwA1rwzHTd4dK4Wjkj8lDUlBSK6BJ91VvoOfUPAEgvSMGQo1P/73wtCDPs/onChwSM+W9h4hRQfbIWVB5hEiPS7cLy0c07DT+bUohRiHGfedYMcK3S3e2fbnPTZ7LYUMH7XVJkmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zv3xNt67; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c22b1f470dso2718987a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 20:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725160439; x=1725765239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vA9fKAepAjJP0Y+uK6ZVIFt69/fpi4A0HmGXHcekQRc=;
        b=Zv3xNt67ZjQzziEpwFTz33fuZbWvHn7A6OD2u2oisxiX8DVElO1G8jInHVHw8kTUUE
         miBYos3XJba2VQxUZMQP5hNL33qD32kP2CagGDqRu++jKRxpTWJNWB5MNUVrIIf++zJU
         x6kURTetG7vjMF39r/DBMMGN8hY2MGFwubcYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725160439; x=1725765239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA9fKAepAjJP0Y+uK6ZVIFt69/fpi4A0HmGXHcekQRc=;
        b=ee5YKPyBqU1kbsl1FUykH6/b4lVKucE0dux3juASsNwu6AB4sT975lkilScKRiaanr
         f22rKbZs168XX1d5QrAeciJdlh+vIjIB2psNrRMmxsHzsAQNeeESDMdhIoFipkY/1kfS
         rJ9no2XRSR213bhKI9acyxA1V/sl+LP5dbSOqMut5FeHzW5ZvZSN5PLNABzIL5657bE8
         D1Ai+6VDSzLHNscvb9N/maBFLprqyz4DSOAyme+ge5LcfF2eB10QBPbUSQ4/trgIbH5D
         T0qHhDYFNjsZe3Yj1ZjhBKOuaDtJSZzo3yokowQU8sOQEaLnuzcq5O7RBkhrtxKnS7J+
         Wz6w==
X-Forwarded-Encrypted: i=1; AJvYcCUfTXTGxzD4e51Qu8GvCNkmZdwd3DlcamjYahzpwhkkIoYhBc9W5DvNqrK/sy3YUrisuyrHFozqwLZglek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLayPCzogdCDwggy7nEWRtDSFWMp92PixIFIqHY8ynkn/lTcJP
	1Y/ylTu3JoIEjJbV66RjWtjGeI5b+3GIhqyYngZ3X8R/2JJOMflCKrAcNA6vCTsecyP9RMxQxkf
	zNrNUqA==
X-Google-Smtp-Source: AGHT+IFqC2B1rG30EATiKIKE/g8Lynq8ZGblnexeGgjGgS6ew7GYkwPBlY0/btAX3RccjbLuT4mxLQ==
X-Received: by 2002:a05:6402:3783:b0:5af:3af2:e2df with SMTP id 4fb4d7f45d1cf-5c242f21841mr2663388a12.30.1725160438087;
        Sat, 31 Aug 2024 20:13:58 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfeb7sm3545481a12.63.2024.08.31.20.13.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 20:13:57 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso2840900a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 20:13:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVm0fxPY9/cyR6Y2leogtXBg4InCo2584x2NXWKMTFx6nQ5t0/xCmPyAwbcvh8b3FXnRfgKw2xw5jlsvps=@vger.kernel.org
X-Received: by 2002:a05:6402:270c:b0:5c2:53a1:c209 with SMTP id
 4fb4d7f45d1cf-5c253a1c259mr266984a12.25.1725160436527; Sat, 31 Aug 2024
 20:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
In-Reply-To: <erydumpfxcjakfllmh3y4d7wtgwz7omkg44pyvpesoisolt44v@kfa4jcpo7i73>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Sep 2024 15:13:39 +1200
X-Gmail-Original-Message-ID: <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com>
Message-ID: <CAHk-=wjBNzWL5MmtF86ETJzwato38t+NDxeLQ3nYJ3o9y308gw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc6
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 14:44, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
>   git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-08-21

Hmm. Your git host is often slow, but now it seems to be even worse than usual.

I blamed my phone hotspot at first, but everything else is fine.

evilpiepirate.org takes a few minutes, and then I get a "Connection
reset by peer" error.

Maybe kick that machine? Or even just use something like a github mirror?

               Linus

