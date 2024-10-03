Return-Path: <linux-kernel+bounces-349530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6F98F7E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4001F223D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83A1A7AE5;
	Thu,  3 Oct 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D9l/LxIN"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AB4C8F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986256; cv=none; b=GDBHNFqSfRKzdavuP23OU+cj1fytaCf4g2GywxG1mygZw6e2aUBiEhkBBnLD0wQJs4V0mEjJdl8zLEZ8zfS2WWFp3Crk6qyabC6nabs8vzFFdRN+zsRrYrxXfpj5u4nncxgzIPtcR6UMgWNmBJBmuBgeCJGnoAyJSbopbxFo5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986256; c=relaxed/simple;
	bh=5mClyvmoE8/T4i63r9o6eFa9xXDQuoJ3ToU1moxvGuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmsAdsNUimUo7WryGzDkZp0w3ydhldE1JAHX0ZzxlpXUeKcHZsVTEbp4+wDa2OQbR+o53lK8EZdshoCe+8F3nek8Uc8Y98dsERtB/dvZ3ORhO6CNeLVkyXsxXYyJHgeVwKbPwwMAMCPv2+YX/XV2xnrSWRmQ3lKmKkzzGw2kZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D9l/LxIN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso22340911fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727986253; x=1728591053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OT7NXgiXezelCOBUF+N5L8bbD4enjmEO6qRhbNzjnk=;
        b=D9l/LxIN8usEpBIQfFHJquDzJ1AOQ10/IE2HHrWzAcYi52b7v97FlA+OBFnK2oEAKQ
         dBBeZNdqgJFwHGwHsh63ruE0DBGyIs20eSoqXsPJ59VhksrlxKxeQWQzzpvuXnQt/wYp
         xPzgKsb/IbM1yzVMsZGU6DVkRxAn5j+a1jd+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986253; x=1728591053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OT7NXgiXezelCOBUF+N5L8bbD4enjmEO6qRhbNzjnk=;
        b=b0l0hOKg2TCPdPBCD2l14PqK4gDsS30AMQhf1IXLvWuMjJsX07wqwAZIb+N4s4e3Vt
         RPnpD4URsQAefiQkB+tDhzCIhFvj4IAH5A7e6CebX+7NZRsnxxH6wEuy0z4yStMn9a6u
         2XGt7CvPWSw7bRNFCVUiH2pRSdvL3r75M9o8dkNDPBrIgYYcWBujwocOF19BV+MJuKTi
         t807NLcHwTyQiYuPX8t3rAnJcKyIEnBIM9wIV5JcImzWg0Wjy94WHOwDOWG9hUkh8KtX
         YPeVo3mhngYrcw8q3TLyC8omwrdM8QWQ2IgQKXlid54D81PD2cLSfJzC0Zvssq7LIWFp
         5vPg==
X-Forwarded-Encrypted: i=1; AJvYcCVM6RMXhHRuS0G+9rbuaFo/GyAdu99t0TVLYyfxtP/PczcvauEwwRiLaWLAZeI8tcdAFhekpZ/dyaTvP+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+Ve9LCnNl+zLkxxbnH7gDdDsMIq6kf3i+YVeoStYh692nr2V
	+HkNASMiORhwrRd0ySA7p9iFaZttJxvSez6+cpCZrl0wmPyZMAclgsU6bV6zXz/Oy/tY5CwwPW5
	Jxw==
X-Google-Smtp-Source: AGHT+IG/RAk7AxbvPhH2+1U4Mofzf6CtUReXrj2RdZkW50+XcD2ZnYPgioO1K8xOCGAgQ9onBlUe8g==
X-Received: by 2002:a2e:610a:0:b0:2f7:5049:160 with SMTP id 38308e7fff4ca-2faf3c154acmr1340551fa.13.1727986252706;
        Thu, 03 Oct 2024 13:10:52 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc115d8sm2845371fa.59.2024.10.03.13.10.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:10:52 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso22340641fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:10:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDyEVhbf3j12PXaRlG9rdPLK6vWIyqpphliSZ3ucsBOUnNAl6MXYOMT0lpUlvWqQdlt0v20sTwQotDliY=@vger.kernel.org
X-Received: by 2002:a05:6512:3087:b0:539:8f68:e036 with SMTP id
 2adb3069b0e04-539ab87df04mr503870e87.34.1727986251309; Thu, 03 Oct 2024
 13:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-8-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-8-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 13:10:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXu79-HOhWuwumJNkpNCup5EHND1nPk5SHyc7Kx9iX+Q@mail.gmail.com>
Message-ID: <CAD=FV=UXu79-HOhWuwumJNkpNCup5EHND1nPk5SHyc7Kx9iX+Q@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] serial: qcom-geni: drop unused receive parameter
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Serial drivers should not be dropping characters themselves, but at
> least drop the unused 'drop' parameter from the receive handler for now.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sure. I haven't spent any time figuring out what serial drivers are
supposed to do with parity errors occur (I don't think I've ever used
a UART that enabled the parity bit in all my years), but at least I
agree that getting rid of this useless parameter makes sense.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I guess while reviewing this patch I can also see that, indeed, parity
errors seem to be "GP0" and break seems to be (strangely) GP2 and GP3.
I guess that answers some of the questions I had on patch #5.

