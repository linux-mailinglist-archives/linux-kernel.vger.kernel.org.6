Return-Path: <linux-kernel+bounces-276311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11F9491F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0F62849D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845721D54F1;
	Tue,  6 Aug 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RInmNIiN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497611D47C5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952019; cv=none; b=I29yzzxz3USPYeVQmv262JqEwVDhaTLNwftf6WYVBQWYiZvmz5fhgEquAx694q4e625+MsAK3pLGkockaI5L34dFmVdPpA/X+PFZgIeH9ITlRtX8erzLCsiMsZpa5e15IjNSVmQzgYbEthFVokbSH91w2HWxkXbJ0iAItdGerQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952019; c=relaxed/simple;
	bh=n2B5+WTR5fHsn5YvtfTT61S48+OsOawPtKzrF6Q/zeA=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=JlXfIk19q3hLqnShsG6QlptxYa/PZF3HvGQoVSsqq11at3WzZEXiZs9/fyzyLBfNT9+5GAManc+E3/SOV0MXx5RYRhnfN4aMP8a/W/wz0geMTi2A7AlBG1oPqa02pzRYclYpChOzlcdUhf2rC5U3iQuCLFP/+/jj6cYYH5Pcrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RInmNIiN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef1c12ae23so7327901fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722952016; x=1723556816; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n2B5+WTR5fHsn5YvtfTT61S48+OsOawPtKzrF6Q/zeA=;
        b=RInmNIiN+eeNotw0XX6QRGDDo4Vz5BSNOqsr7t31+sXCQShZRndAwAgU8woTKSPaD1
         zNOSR0IL8GOWKrqmxNByZnedfzbKiOkBm72x4IvOWqc6L1tOO3s7rclaRWKykmig6/lZ
         hI5MtGO6TaR5XciWt4B7DTSsQOCEFb20Mbz07rjyOswAqZPAptZp5sV77dYdEQDzt4ec
         J7DvboYdcgGriq2aEdORMAEMZYGjf5fDPA6iJuqKZ6omxWbziuemD/MckluXnvcLnSDk
         RsAr+uwnjSnp++9pr1PGkYBgQ1ToKyTVT2I78iTL6kir0UmmKezotfOzA4zH048CT6Ic
         yMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952016; x=1723556816;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2B5+WTR5fHsn5YvtfTT61S48+OsOawPtKzrF6Q/zeA=;
        b=SI7V9KcFErHeJhSh+3U2LlK665vYNkPNNHdKEpSqC1wkShyTjbZtE5Hen11s2UIsZu
         3LwX1Js5Rj+hcWU/JUZdUx5l9nnf9yW8tHZLwo/852pa5YY+jL0GO8HWUUeItCONHHMr
         Lu7HN5GrdYWYCqQlCesvx2clDbwfWwaKwbvR+F501pRxFGVLfzjBDsuKL5TKlHS9OJ+H
         k2+6oaRdRlv+ZTIWSCqsZMhXpDA8zXZhwz4T5LYTyHUAOpE0t++5t6Gn5jHXmceQPLF8
         5boxYOv6GpGWRFje8DuxZeH0SzK+tznUFHM0iUE1ZNiKaaeXDU1Je4iQYa3w71RUeGh/
         O0Nw==
X-Gm-Message-State: AOJu0YyC2/iuOLVVmtxjrugUYAv4YxCYj7TW1/Uf1Q5NZ5sg8Ld1UIM/
	ySBqV7ix9Y/Yjg1tKtVINCjcDXyhPfg/hxCAvZwM8w9uNXu7WS8Eh8ty8j8G
X-Google-Smtp-Source: AGHT+IHVAKkRa7rhYXcrzYxWQbmKI9WHj7zSE9Ri44viOL/egdfof068pzDm19XS2NycPUtLNlfBGA==
X-Received: by 2002:a2e:7006:0:b0:2ef:2016:262e with SMTP id 38308e7fff4ca-2f15a9f028fmr106869991fa.0.1722952015670;
        Tue, 06 Aug 2024 06:46:55 -0700 (PDT)
Received: from DESKTOP-KPV6ART ([39.45.132.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ad475sm244395255e9.13.2024.08.06.06.46.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2024 06:46:55 -0700 (PDT)
Message-ID: <66b2294f.050a0220.2b40de.7b33@mx.google.com>
Date: Tue, 06 Aug 2024 06:46:55 -0700 (PDT)
X-Google-Original-Date: 6 Aug 2024 18:46:56 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: elvislehmann891@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Bidding Services
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCkNhbm5vbiBFc3RpbWF0aW9uLExMQyBicmluZ3MgeW91IGEgbWFqb3IgZGlz
Y291bnQgb24gQ29zdCBFc3RpbWF0aW5nICYgUXVhbnRpdGllcyBUYWtlLU9mZiBTZXJ2
aWNlcy4gV2UgY2xhaW0gYSA5OCUgYWNjdXJhY3kgZ3VhcmFudGVlIHdpdGggYSByZWZ1
bmQgcG9saWN5IGluIGNhc2Ugb2YgYW55IGVycm9yIGluIHF1YW50aXRpZXMuIFdlIGFy
ZSB1c2luZyBjZXJ0aWZpZWQgc29mdHdhcmXigJlzIGxpa2UgUGxhblN3aWZ0LCBCbHVl
QmVhbXMsIEFjY3UtQmlkLCBBdXRvLUJpZCAmIFJTbWVhbnMgZXRjDQoNClNlbmQgdXMg
eW91ciBwbGFucyBmb3IgYSBxdW90ZSBvbiBvdXIgc2VydmljZSBjaGFyZ2VzIGJlZm9y
ZSBnZXR0aW5nIHN0YXJ0ZWQuIFBsZWFzZSByZXBseSB0byB0aGF0IGVtYWlsLCBzbyBJ
IGNhbiBzaGFyZSBzb21lIHNhbXBsZSBlc3RpbWF0ZXMuDQoNClRoYW5rcyAmIEhhdmUg
YSBHcmVhdCBEYXkuDQoNClJlZ2FyZHMsDQpFbHZpcyBMZWhtYW5uDQpCdXNpbmVzcyBE
ZXZlbG9wbWVudCBNYW5hZ2VyIA0KQ2Fubm9uIEVzdGltYXRpb24sIExMQw==


