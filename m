Return-Path: <linux-kernel+bounces-301583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B795F2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7546E2824E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A922185B43;
	Mon, 26 Aug 2024 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h1C/a36l"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D82C95
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678741; cv=none; b=ovWSjNjXKibM7u8zfNnrJThuksLoWniNRVESK9MNjzmBhaJEMZr32S0Tb+kNEwLSIzGxLODJjDkAvTXuljN2DeDQVyo6uE0jUmZwZUep6yuS799SFz1aFxJ6zH++7yfrysj7DLjaEmSeBEnNav92J7QGH8k6OhBhlLDSN2wNZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678741; c=relaxed/simple;
	bh=TDI7RHZmYPU1nDMJ8ga5MjvsFwqpGuSaA+HiyoDW2Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHo2J0C80BMaalINN7TQ/BzaahHJIFwuBSbvSdwnQ+DUiIReX9ytkg1+Vj9qlTcbtpnDwGJZ5A3+Pve2l4fsI5xLCFFn1BnBguggTKetCscVgSHAC3eWb/g8BiOZBTawtrjLt/ua7inwZsrRdjAOmIA6N+5VwYcS7AMPrZNBYMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h1C/a36l; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20202df1c2fso33880075ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724678739; x=1725283539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iEG9QzXGotldnC0jKJGh8tD1wiLvFhSEoIACHY/bqXg=;
        b=h1C/a36lx+vohIhcNxDlXvhIfJChDM9ZbAwY0/VGdM/DRKLOwBTx14xUYTKRjB2Ajh
         r+eIGVhtksvD+FrJc+AcjS0YpuhS6NddnwZAbF2yuZEUfff/lz4fpsNFKChIxkL3kEPJ
         80mErDUKJlkyw4hdOHQjNrO0WnO6175/SBp9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678739; x=1725283539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEG9QzXGotldnC0jKJGh8tD1wiLvFhSEoIACHY/bqXg=;
        b=ADezKCPxeQ7vwtDWzLFCz4VdF+2QSnEzYGvqyRxzplH0PnPNBFZYa1TuvRQ7Y2oDZh
         9+IGx5kP55Lv+FrLeam4xwIJ8MnO+un3l+aehpbWiu1z6Y5zpBOZdiHG5vtBNbTGpB2f
         TzfMqqrH17Bu2iRQjV8orB3xLr0Gt+VifrIzT691Q2t9fH2xam97ScS0o9n5cgTz0RwN
         +9U/ue3cm/XUjTSKQrT6YphkF/GnjKFms5vAgu1Whe4kTWR4I6as/Hix12xtL/AY2792
         0CWAC3f9RYRcjGTQzeSdWiWSLAg/+H8WAf4r6SAfsBdO4AURpQTScURQbMpitISeF1/L
         frkg==
X-Forwarded-Encrypted: i=1; AJvYcCXLFo7qJJ31Px0iP/E57vLe6URDcKlffEnAT0RDPETf0v6L8k6jqkzx7r6Qt/CwGBD0AOt+XbWINIvhHYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj55Jc2meMj916/+gzPqknU/1SOtCW4DJhHlwWPuJ95d0nw2KP
	nznJNMb47YwSbJuhK+3K+dByJpI448dR2f+jHU+oKt7bXU56SgkH6O3p6osurc+XepGpJvF1aVk
	=
X-Google-Smtp-Source: AGHT+IELLqth869JaOFsGZgXKQzQs3FV9d2io/Bm71R3S9u9GDO3T9wymsvrvvpbaW/7vQOYK3sDtg==
X-Received: by 2002:a17:903:298e:b0:204:d4a6:c68b with SMTP id d9443c01a7336-204d4a6c799mr23964805ad.16.1724678738867;
        Mon, 26 Aug 2024 06:25:38 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385580f11sm67241505ad.109.2024.08.26.06.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 06:25:37 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021c08b95cso39922645ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:25:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvkTPfON7cSgV/yVICsgRK8cSmYv+73W20eNeYH+r9B+IT0OzGnbZK1kJ2dGdkm8k5jePoKbMUG7mHyxw=@vger.kernel.org
X-Received: by 2002:a17:902:c412:b0:1ff:5135:131f with SMTP id
 d9443c01a7336-2039c509ec7mr168440465ad.25.1724678736416; Mon, 26 Aug 2024
 06:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620145820.3910239-1-mstaudt@chromium.org>
In-Reply-To: <20240620145820.3910239-1-mstaudt@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 26 Aug 2024 15:25:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCtF8SxmphDYkLwGiZxNE7ds2NyK8MRzD4=dg3W2oRhG7A@mail.gmail.com>
Message-ID: <CANiDSCtF8SxmphDYkLwGiZxNE7ds2NyK8MRzD4=dg3W2oRhG7A@mail.gmail.com>
Subject: Re: Fixing IPU3 IMGU warnings due to extraneous calls to s_stream()
To: Max Staudt <mstaudt@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Tianshu Qiu <tian.shu.qiu@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tried to get some images using a Google Pixelbook Go


Tested-by: Ricardo Ribalda <ribalda@chromium.org>

On Fri, 21 Jun 2024 at 06:46, Max Staudt <mstaudt@chromium.org> wrote:
>
> Dear IPU3 driver maintainers,
>
> The Intel IPU3 IMGU driver no longer shuts down cleanly since v6.7,
> because vb2 now complains if s_stream() is called multiple times on
> the same object:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=009905ec50433259c05f474251000b040098564e
>
> This series attempts to fix this, but needs a review from someone more
> intimate with IPU3 and its driver. Could you please have a look at this?
>
>
> Thanks for your feedback,
>
> Max
>
>
>  [PATCH v1 1/3] staging: media: ipu3: Drop superfluous check in
>  [PATCH v1 2/3] staging: media: ipu3: Return buffers outside of
>  [PATCH v1 3/3] staging: media: ipu3: Stop streaming in inverse order



-- 
Ricardo Ribalda

