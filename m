Return-Path: <linux-kernel+bounces-296160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02A95A666
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1336B240D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A30A175D2A;
	Wed, 21 Aug 2024 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEOnz/9W"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E3170A1D;
	Wed, 21 Aug 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275121; cv=none; b=HlWaDgCImUxsjEYJlYWzQOOja8oIcxO+veOLMvBtn1CZNwIssfrzYbM6OD9J9YlTenr0zwltoFAyLOlNx6vRo19cM1aGnCkZFX9nWRa6a7DytMzPBwU7o2p5pgzoAZR5RX/z8qT+k4bZATnghp3yxPciqgp+bUouKPe4u6AcnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275121; c=relaxed/simple;
	bh=9Ieq89fKSBVTEvc+D8hBKOSACthGVLaFkrxnq1bQ9W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exeWN7qoH4lQzSxXgJqws1/Rrn/A3FKk2fQcrwh+WwDStuQH2YmBP2j/G1tCCjhU2tnxlKd66GCes3HGhmoclqaFeE8Wg+tgIQFU8uxuH22FDewDnc6xq8G3X4Hj8G++RS0sG+hwPf28FGFapOnqunWn9pIuuy2Ms0TJICs+mSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEOnz/9W; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3ce5bc6adso1173551fa.1;
        Wed, 21 Aug 2024 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275118; x=1724879918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ieq89fKSBVTEvc+D8hBKOSACthGVLaFkrxnq1bQ9W8=;
        b=UEOnz/9WB0m4s9g9ePGsymkD1TJIDQT++bddfpocw5+elyawGlTk14+UVDaYM+iIFm
         eqHBBcHD0Ww9VkR1+cDWn8H4PbNnShKjVCbScTv62fCzfcaljBn7uELOS6QZorOh5hNu
         0BS9N9c9AhymItbxxST0IFYqvakIqk6FkxH84BEr2Ag6XKcvmwMUCmOJMu37FDxSyQWX
         uQLI/zsOx2eWWagI6djjPXO7IV2zUIhnEmlbhs4f0ZoFWw66KIC24llA/+Q6aWnm8UDR
         uO8bKrSEF/NwslqsbZwGO81EWnZilZM2uiBjSV1kOgGk9sKe8LqPe/eP4WEX67TwnzM7
         TqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275118; x=1724879918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ieq89fKSBVTEvc+D8hBKOSACthGVLaFkrxnq1bQ9W8=;
        b=PAUGF96Nb9f1NHRLMmgcFgsP9ed3wOYK36EUgeYSUX08h0ePY8gQOZ3czsrM+XbZTi
         I4zavDFaQeWygk6DM7Lsx5KWXyvUB3BBVzPfx/Ykv3TubGpWz3mc0mSXuUYpIw+rHmU6
         kzr3gvZW4Weu8q2yAHA9JfPOEf7FkIxZmVeaJASAlBeZ5DCeVivN7QD204Qspj1m2zna
         +TfkNp42ThorRd6IN/88cd6VFtPsu0xEP8TQNpdoYPkOf3GkfFqGedN4QQs8kMIM5A+J
         8CRtCHE+oNAu1wZ47FgKPg74UoI/y8fEZiU7CZotvLq7qeKn2qZlBVV0fnrxZ/eKpYTY
         DKNA==
X-Forwarded-Encrypted: i=1; AJvYcCU6I0z9kzbNiVxTfZ7sGdj9AVcI6QcUPD4saw/0bWS2rAQiZ82IqUOZLsZpXYUNvYAW5Bz4oCglIw+T@vger.kernel.org, AJvYcCUViSEFsOs/JtM80x+esuIoMT6Khcu0AdXX/kb71SsIVEA9tUQXC1nyAp0hIOluefTECOq7lbtwOn6LKmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo6i0/W/rco8CIqnOaLtNoutMoaLn49BLHaNXXMjZJReYtrVoI
	LEL/EPtZKdD6twqROYe+zjrqKZSnZ4QXCWe9v3ySE5gS8ri4bAqiXeXCpp65ngcM9ktBpW0AuEQ
	1paPz4+eVfNoTiO7mCIrhw89wxNk=
X-Google-Smtp-Source: AGHT+IF4A7L+53ZaTf2fExGKqcZZk+WWzGG1SGAa79vRdOnrxfpve6MYoUmDpikZKNIKs12zBAuH1wiPI4qxB86GMfw=
X-Received: by 2002:a05:651c:1502:b0:2ef:22ef:a24e with SMTP id
 38308e7fff4ca-2f3f881e268mr26168671fa.10.1724275117923; Wed, 21 Aug 2024
 14:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-dwc-mp-v2-0-2a29b6a5c2f4@nxp.com> <20240821-dwc-mp-v2-2-2a29b6a5c2f4@nxp.com>
In-Reply-To: <20240821-dwc-mp-v2-2-2a29b6a5c2f4@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 21 Aug 2024 18:18:26 -0300
Message-ID: <CAOMZO5BcTyuSxqyBEESyjVy07RhA8YtkHqByfCgEfMgYqVbVjA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
To: Frank Li <Frank.Li@nxp.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:19=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Add 2 software manage quirk properites (xhci-missing-cas-quirk and

Typo in 'properties'. Please improve the commit log.

Why are you adding these quirks?

