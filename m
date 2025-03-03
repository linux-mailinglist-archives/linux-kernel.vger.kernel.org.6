Return-Path: <linux-kernel+bounces-541062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CBDA4B7F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9028188E232
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2F1DC075;
	Mon,  3 Mar 2025 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClvFCYbi"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A54A3C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740984527; cv=none; b=ZK3yJRwP6bXO0KTBNLs71QGsNPc2ExpevONSE3E4TJdk4IYPezzCodyrVT0Ts1cD7/KyaDtpuVT6HE5dbcIGYyn53u8ScC9ZQK0b6RmySJEnK5koGzQR+5iM1gSzGEMwsJ6RZRERJeE92lHOhLMkaF+I3iM5nYYPdcV0aJPnImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740984527; c=relaxed/simple;
	bh=1sK/sG0bVrYAZ+EXCZ3PcRsXfPbFCWiPRkn7lJ4a25Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XmeiNVAahcBDL4lkKdCFxlSaEvbiRU7h4XxIz6UPcWqxTD56wGg/U2JBEX6AikuAeidbGvqmdo7KmISoyNQs7a5W28Zcwn1MnV4yG/qZt6KR431aDuY8uAOyvckQKWDX5DwpOhqsLtnZSdxkf2I0U9AdiM/5yZCm8xNHK1d0TzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClvFCYbi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223594b3c6dso66264865ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 22:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740984525; x=1741589325; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSZbgNGYKxBBihUiihRMM3Eu6IeHMnI7bsOvB96WIr8=;
        b=ClvFCYbidsvRCgDLOiVXrI5rRgvwwXXSUv3A0JhAnChFJ20T5G61AgW/46XzNW2tYk
         IcTb5BUfAxctprOMaUFdASm/AByln4Tch6K8n/nXiUJxGbkcDPCO5gfmiAVxjYdQU38l
         M9V00aBZcJkZ73PCcH4KhTsQlqzjiBFbk9cr48ZCKI8D3wekdlZwP9enTyEhGWbfEk5P
         7FoMNw5GpTaQjYdtQG8iM1MUA9kziXRMm3ro6PLQEre/WG6JWIRziJv7FjI9NtY8DGVO
         1mc18XeQL8VGNQQtb/vp2yay+miBjiRYBefC66JkSL4G9HHTu1+mpVrNOzMKXr6vKaK3
         BNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740984525; x=1741589325;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QSZbgNGYKxBBihUiihRMM3Eu6IeHMnI7bsOvB96WIr8=;
        b=LONxmLaxBdXTzDPYQG0dnY3krBxDZ4NpLjHlyg1AHZbH6lg+7p65XSvTnDBKk/AQdR
         M7IHY78MF1/1O+siv5s95tQ5RqN0lIqAMORTzBsaL5w7sB/cKTzYS2ddxT2FmWVNLKAR
         YjrIvNMTfx4zWK4ADoLo5oaKH3pkQYF8OV6sRuXFTPUft+eSGmnxU958CW3VXonpPL76
         5e1alhdmapqoYiOzCQPI+a0FlIHQYYNWhXwCVd+VudNyo1SZ7FsFP+6EVkrf82wpTU7m
         DEkw4wTRHvHPTWxkpRK8XuwKO8teVCpPWG9NPaRHRpi2RQEg1BqMVlFcb4RCirjl84vB
         OvsA==
X-Forwarded-Encrypted: i=1; AJvYcCVmgfy/gBf4ibZsQEGRY7QpIB7NjMFHZvnNXZOzWBw+06IS/jhrZUlck2emK/lRnBAYcQt6EqkViGHBrTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxD1jzLijzSp/QdQ1QroGzvMuc8LdzvhXlouu9m+JVS/brJP/
	ASZV9Le62wa1G2R3+8sTRrASvs2VzBEniS0oC6IXUwfDKSQDYjAYqhCzgngG
X-Gm-Gg: ASbGncvvRoGCnmrzz/76PB8rKNz6dpCwUvtXmqCHvsJgeMiE1MJD+hlZuEUSxKUW5a5
	0yjdcr7bm/FT6NkTb5GHqmvx05fjijIFpTgJqtbS3i7JY+xCgS6U7hnqi6mxFJTXYGFXslDZhYq
	74STIyxFi0AztVQqzqRIrbvGUxgEb//VpQnUH+uk83KvC09yAiaVjjcQps6KH1Izfi8Hh9Ra9Rj
	KpnDH7wg5MFtdpxTgZlTMWI0kaasRDaDtfxX88wiqv/YI5c22/UC9WdIdVqmtVT1/iSJ54q1bkB
	LxRdNoZ8rfTXkFQUDFsyoTVboRG+mVE5E/uUhxzo1A7gpBSEKV5zNt8=
X-Google-Smtp-Source: AGHT+IEA1hJKUxyqA3LqCYci0qeTbUzcQpNPUyQbmM5kCwjJ7k0HdhHQIwOWW/ooFknj5MyhKAzw5g==
X-Received: by 2002:a17:903:198c:b0:220:e1e6:4457 with SMTP id d9443c01a7336-22368fc987fmr204482065ad.26.1740984525199;
        Sun, 02 Mar 2025 22:48:45 -0800 (PST)
Received: from [147.47.189.163] ([147.47.189.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c596esm70571005ad.152.2025.03.02.22.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 22:48:44 -0800 (PST)
Message-ID: <76e7268f-c4e3-43a3-957f-b7246d953c6a@gmail.com>
Date: Mon, 3 Mar 2025 15:48:42 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sunil Goutham <sgoutham@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Kyungwook Boo <bookyungwook@gmail.com>
Subject: Null-ptr-deref in xcv_init_hw()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

It seems that xcv_init_hw() can be called in bgx_probe() regardless of whether
xcv_probe() has been executed, leading to a potential null pointer dereference.

The following is a call stack example:

bgx_probe
  ├── xcv_init_hw
  │     ├── readq_relaxed(xcv->reg_base + XCV_RESET)  // NULL pointer dereference

In bgx_probe(), if the PCI device ID matched PCI_DEVICE_ID_THUNDER_RGX,
xcv_init_hw is called:

pci_read_config_word(pdev, PCI_DEVICE_ID, &sdevid);
if (sdevid != PCI_DEVICE_ID_THUNDER_RGX) {
}
else{
    xcv_init_hw();
}

However, xcv_init_hw() performs an MMIO read on xcv->reg_base, which is expected
to be initialized by xcv_probe():

cfg = readq_relaxed(xcv->reg_base + XCV_RESET);


Could you check this?

Best regards,
Kyungwook Boo

