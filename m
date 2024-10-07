Return-Path: <linux-kernel+bounces-353071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0249927F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3640283883
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A018E767;
	Mon,  7 Oct 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTm0igan"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE418C021
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728292751; cv=none; b=IVcm/SRskHcft/KYF7UdM5/ZYae+/UY2I40l8EcY2TGUnsmqj8E0iIf6sjZX+DlsOJMWf3N0aRo8jQBGVmwkUZQ3/k7oj7JcQcrlBobXBrANPO83VZNrZ4awKvIAYTfIkfy+clEAvTvujAIJfxNtYBUJLBrX80/9lKdLmqYNxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728292751; c=relaxed/simple;
	bh=F7BW08yi/TqT4Oypn9Wo4QEw2rpXjXPwZ3iTnj526pg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F1b4RL2J9pqoMmCJ6pbZwV2lUwUEyN11T+z/W9uTP//Pi7QP0JELr/ledyQKsLnQiO71vqc3+8ACAzww7Zn3/OUmv3OYrvomhCBGBDR9PkVS5mDuvAb6zFsBU3SdcXCz17EO1pRtJRPtVikrrR8+h2z8bl7Rky1BCxWtjBPbLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cTm0igan; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso6095265a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728292748; x=1728897548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDtT/Q1XTmJvwzXCH/BrGcqMEpz9Tk+amaIicF76VQg=;
        b=cTm0iganAwYkdT7bQjk+8FL4JuBjL7dNZPgx7nOtQ/A2c9INq843BeeH46odmxmewb
         aXq33QNl/K1btYAdlUD0gzOyvM4sTNKqLd3M+GI+R0IvWWNFDImM7jRQUL+MGyHQOuG9
         vfBFnd6zWbool3hphpghorOA8hl0PYqH+YwVfZEMfqGuoI8LnIa4b3qj6i18GQUnFRq7
         2Ur1w7f1zTwctddytIIly9iKv06TWiZUW22kZCSV08gVUQ5jUhR3vTtsg0pn+UPMq6pr
         j01TIppfmPXuaLx1z0DqgWrRrMNeaWSszzKoeR3swL4XVw9H7WsSnXdu11g7Zv45Wb9S
         z45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728292748; x=1728897548;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDtT/Q1XTmJvwzXCH/BrGcqMEpz9Tk+amaIicF76VQg=;
        b=Yd8ccMOwQvS6E6PGv8OM8iuf9XEsmW3eyNvtdd97P55L1w2DVDl0RwjKG1oG4pxJNU
         JEPM65VOVnFcAia0V4CQd4KoriaFJh9C3+UjXusfmrXV1TacG1VfJCm8uk54Ow4euHWI
         fwnwpLoJRrw4tP6aNh5BXae4X/m+X0HgzBtYkYtXdBVyrlcKvJbxrW8dowG2gmGZOOul
         /vmLnp0djAwHjAmdl8zIdBlNICOEercwXllJaBC4smQmGtwBxSAoObvSUpIMKWi4Oo3b
         6ZVV9ce5y6v/IYcWqprtFc714+ygwFV/032M4ICDph/UmCnKj28ghGxZmiPiqX/khuJz
         0aQw==
X-Gm-Message-State: AOJu0Yz4VZCvr/reHMrzx6i+mxGWoMPvi+DPbUouNzE0eZLf7dWM/7ci
	1LQrCOEA1N9zBWvey0r8JNthpZm8od4BTZCcmCrGmEZMb11bzxW9urbpVjLZ2Tk=
X-Google-Smtp-Source: AGHT+IH+6m1YkwMXVOkl6TkXjnE/eaf0zhr1Z4Xo/BWqFMOVdHxlq0A+mkqWIzgJQbOZYRkf+W1LBg==
X-Received: by 2002:a05:6402:5112:b0:5c8:83f1:2531 with SMTP id 4fb4d7f45d1cf-5c8d2e742f5mr12005516a12.28.1728292748347;
        Mon, 07 Oct 2024 02:19:08 -0700 (PDT)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eccf0sm2957830a12.64.2024.10.07.02.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 02:19:07 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vz@mleia.com, claudiu.beznea@tuxon.dev, 
 Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 opensource.kernel@vivo.com
In-Reply-To: <20240930022922.7369-1-shenlichuan@vivo.com>
References: <20240930022922.7369-1-shenlichuan@vivo.com>
Subject: Re: [PATCH v1] nvmem: Correct some typos in comments
Message-Id: <172829274753.180677.12676697977230217480.b4-ty@linaro.org>
Date: Mon, 07 Oct 2024 10:19:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 30 Sep 2024 10:29:22 +0800, Shen Lichuan wrote:
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> -in the code comments:
> drivers/nvmem/brcm_nvram.c:25: underlaying ==> underlying
> drivers/nvmem/core.c:1250: alredy ==> already
> drivers/nvmem/core.c:1268: alredy ==> already
> drivers/nvmem/lpc18xx_otp.c:24: reseverd ==> reserved
> drivers/nvmem/microchip-otpc.c:159: devide ==> divide
> 
> [...]

Applied, thanks!

[1/1] nvmem: Correct some typos in comments
      commit: 3e93f43ae64b247516176ced713888775167ae8a

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


