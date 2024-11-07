Return-Path: <linux-kernel+bounces-400044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9039C0831
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BE728225D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177621262B;
	Thu,  7 Nov 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btMjS0Hj"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F5C2076A5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987717; cv=none; b=chh3HoUu0LxFRGecNCz7GB4Fd39Se5cwWvbfZ8dIsOeTrwUQAYPDe7lUyn0OllQ6JVTZ/+nnGzok//vq8QXsX0XOdxTlbgftAR2AKelV+krDmWvldurTfLjvI8QQNS4e0STQucjKhBvPTzDsvGBmWmk0TmnZXoavteornwMgMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987717; c=relaxed/simple;
	bh=pAUOPbJ3bRm/k22zy5CUSLWAw1T4ExN+FFkWUH7eKiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqyK9HVpxbuqnbGSQwCVITCu8Vtl0W4ptpB5kkteGo2zJ5vbgwDQQHNBrsi8V0kDwvhIf8L8az9redAIo8kD3pGioNddlTLmPFyDgh50If2+INIn52GNSxmMT38mCcTrYwVgzs+y8HEySQqAuMCWb9nsJ4VHCsTnyOXE9jwW1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btMjS0Hj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso11212421fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987713; x=1731592513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAUOPbJ3bRm/k22zy5CUSLWAw1T4ExN+FFkWUH7eKiU=;
        b=btMjS0HjxZAeXGEnGFOLLBgYUAUYl3vocHmgJNkxSx6m8HlrYxFz7snxjclNc+BXsx
         iwv9eI+zya32tSGIZl/8K4i2iNaB2rB1OiEPJj9167zIHteN3OEt03gsdpTRGxusqWiw
         dfUITdPUQrrwy+PPt75ENkehrlSOfH0DRTC6Q02XCy67QZEOSDCcPrelC7YYlsIY/yg8
         8NZwzl7+6Vxrk5rBvl7dOyEVVA0n68cxsJfadQQtnrTATla+RwB8t23031rgRiendQki
         pkJXyhYCPCFfXtWaSUfURXo31nvy9Y6f+bXtCJZa6/MQ0HIKEY2Wkw7HLR7Ae6qCXKk4
         277g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987713; x=1731592513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAUOPbJ3bRm/k22zy5CUSLWAw1T4ExN+FFkWUH7eKiU=;
        b=eSNwgEYEX0jVXv70ZvpRqiONOIsLRbRRlgBz1pX8DjQ2GW2Bqcj2GXgTWRIfdKWL21
         BmD6bS8N90mWFpe2Hvvaq/sB0crP0wjyd0VqvPVBi6XtND90rI83HTOtI6fSAp3yTRLy
         WfzCcib78uOiekizXUJoLPY6CzddrJfxw9iCSBehVnMputc+n0uowNPd4QBJO/CTW+ru
         9Rw5t4m0jmub4JjUAuAlOPUaysOKQYzYryJ23kOLakl1RIo8YHBncNOQQY3XXaGUC2b+
         lRUlByyX1Rx6K7qNBvn82GvZCBRZHCGgwr0o9I/6Xmf636d/zlwFdufuyuLuHNAlped3
         aLmg==
X-Forwarded-Encrypted: i=1; AJvYcCUSwXd6EMnGtT4MbbUOuhziN1b2JPXfKbnqqYab3P13miAbgiD8nYa+K1poY83LvaxORHJpqoocoEsiSAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzenI2l6PKfRvbsO9eCAke5k/qCWL3TqlnzfHhQEulNAUVnracL
	t6ok2B+7B+bKxTAC9yyrXnoQqIQ2bogUXwWHWqZ010c6/3XpeCTRXu6/QUinsrbEDb3Rfph5MDe
	EcIpi5b6Ot1adUhUt9xYSyS4H+1oH5Uq6/3z2Kg==
X-Google-Smtp-Source: AGHT+IFNavuHzM67z8nD84tGq8SasaggEERCVa8QxVSdpo1jnmEECTHbl3HJt9yjMo5chmDOsynf6pkzaU7GoLeC2Hk=
X-Received: by 2002:a2e:a106:0:b0:2fb:579a:fff with SMTP id
 38308e7fff4ca-2ff1e9044e9mr169261fa.8.1730987712796; Thu, 07 Nov 2024
 05:55:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-armv7-cacheinfo-v2-0-38ab76d2b7fa@linaro.org> <20241014-armv7-cacheinfo-v2-2-38ab76d2b7fa@linaro.org>
In-Reply-To: <20241014-armv7-cacheinfo-v2-2-38ab76d2b7fa@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 14:55:01 +0100
Message-ID: <CACRpkdZ1Pkd_iKDNE+m_R4Anbdv=dcg77oC95yqaAM_dp0BRYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: implement cacheinfo support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:56=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:

> On ARMv7 / v7m machines read CTR and CLIDR registers to provide
> information regarding the cache topology. Earlier machines should
> describe full cache topology in the device tree.
>
> Note, this follows the ARM64 cacheinfo support and provides only minimal
> support required to bootstrap cache info. All useful properties should
> be decribed in Device Tree.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

It's really neat actually!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

