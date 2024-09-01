Return-Path: <linux-kernel+bounces-310421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299D3967C87
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 00:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8812C281860
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A9618595A;
	Sun,  1 Sep 2024 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQeKyTa1"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855113A3E4
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725229030; cv=none; b=BxpiHUqoKOSHiJfZViEqD/o08toAX+tnMfrD1Bmt42X//88N/BpiJkK2w+PDtv0xelpAjHUkD3EEVgi5Pqrnxs/KGJcNUUOsvgXZEj/AZbEavDbHFGk7CQI7DjK/wt7iTBJq4jI4ltQTlqB0yOkZRv/QNit8tNHm6GYmACb5wb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725229030; c=relaxed/simple;
	bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOBl7+uqZLbxBknDeDN5jyXlBLWMzfc5FzL4Pgmw69kZH/oIVUgSwkXV3pEgtU7VXcSwhH1EYMj/yxIaryDUG4zCE6pjuuRruGnmUOlhFDLbL6FJZNodpQhjIZCPI9c0jENWQBjFg0lV8DjOqGvHZDp8LmVUbQOb9HFgF+VTZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQeKyTa1; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f4f2868710so37868601fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725229027; x=1725833827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=QQeKyTa1ZHOmdeLtfJQ08oELr7R+lfjvt5DWUSh590msEz57AUPas1fkl/8ZGMqRgl
         0Iu0opmnDjxtg91FlE9g3nLLVZIYs50mxBV5jwuLKOjV3UYlQireUyT2TB0yDh4uiyY9
         sFtNWX0fLiMvj9AeZrRxEqrF+bKgbpxgM33j4hZyIe0Z03WMeeSWO1kFXH6F/j/FpT+O
         LPbqPI5pFhod6fbBZohITmA2zN+58+S9hduNR5fIkbonsuvPHo90j6DzcN3Ur9pvP2n7
         HJ3t8xY12Wz/oB/4ZwZ99EeBsVnJwZOg+nfyyYIZRdOCq879DzKlIyBArjAGBEukeuSe
         yKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725229027; x=1725833827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9KquY+Xq9HYGt1l9PNrkt9cxTRdMnsMxi8cD3m9plc=;
        b=W+/DZ42Qb5wuHeVVnn/isFPSEM/DmGyCYQkVyvOvmWdywFXm5WKWQS5FC/fARIOerP
         8gg6ZWcHZ2LVMHUVBlTRIKNeeTrpJAfYVIoSG3xRm+sP4jzyangzBSYI7g+mDO0YRRvX
         wktXCahgc08U0TWPT6LD64Tt9lE6OLPKXdOMeVrMym4YeGdcpeJ2NjsARDKS88VyQXlR
         EAXtJ055pFHbtqNWwzNkhnGsAL5Ela0YxK/e6UH+TKBeGKVCZS8N+E58T2CKzS8FiRy4
         a8jOOMZI/XS7OF3BQkEuJSnLCkOv/J57552iBvTqpPUAMtzGHbInKyX4KsXcnGCWfKFx
         kdmA==
X-Forwarded-Encrypted: i=1; AJvYcCXaB6oktPhJiCGVR0dQCt4alVPs8SeCCW9oN6AnhwUHjxT0ox0+Kc6QAUvQSRqn03ADBAj4j1PO1OJtItQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOYO1Km1epAcQ/agM4k7ThW5Oa62Ss/RvBXhz3jr5fFS0GMKf5
	Wrl5Yvsr1z9Us3I5OeW6tWdSD3IBClSxgN2uiUSmIV8Mc9mjsj+OgzAg99bIA96062IGLIwRXTT
	3uh8RzFT2rG6guTVRj0kdYqgkkYe6Rl8Iy28YXw==
X-Google-Smtp-Source: AGHT+IELtYHgrwEdRxYDgxD8aHpOX0/GHHaDJQOuj7XAGfQNHkEYFfltRh55fb3ghPbg2gbymDF7rNGgW5udWeVIpUM=
X-Received: by 2002:a2e:be87:0:b0:2f5:a29:5a42 with SMTP id
 38308e7fff4ca-2f6108a0ed0mr86585481fa.14.1725229026305; Sun, 01 Sep 2024
 15:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831072158.789419-1-liaochen4@huawei.com> <20240831072158.789419-3-liaochen4@huawei.com>
In-Reply-To: <20240831072158.789419-3-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 00:16:55 +0200
Message-ID: <CACRpkdYv5bcDM6B42_pmkEtaiFNQ-mqZzHOPW4UZ-AsPiwuBDA@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/3] ata: pata_ixp4xx: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, 
	dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 9:30=E2=80=AFAM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules can be properly autoloaded based
> on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

