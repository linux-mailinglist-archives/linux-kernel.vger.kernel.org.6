Return-Path: <linux-kernel+bounces-315556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2E696C424
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEB11F27D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8651E00B6;
	Wed,  4 Sep 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2xOdbMBA"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EB1CEE89
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467469; cv=none; b=l7L2HA5NCVCrWIC2us1OlJSEp0SFelJWGq4wOBECnbxWw9p2FL8GaUo0WxXArmtn+xzeDDHCWb2wZ9nx93klkiX2UuvsS0hbOwpsDm7EnRDKdPngvtLxpYv4hwW5Zo9ohW7Yf58kJSnEY7h0h2XVRzeG/y/b90YkPW7yfwDaQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467469; c=relaxed/simple;
	bh=xbNSgcdt23Q7rokBKs0uIKGlDc6DJJ/JldN4DLaNghM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAz1UsS+HsaS9q2NxwCovdFG6XNiD+dZzOSLHMDzApKBSBDpaanil7qIZXVFcaPa8GJueZIb2GGpQfaoNgAnkn6XPQLsh5ir9kehVtsxTQ2ksngW3qMj92DkMKgJw7/mxgH7X4GYt0Jf318/eFOSW0MfCvy1rbZtqM3vfi3ReKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2xOdbMBA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c09fd20eddso6592821a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725467466; x=1726072266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbNSgcdt23Q7rokBKs0uIKGlDc6DJJ/JldN4DLaNghM=;
        b=2xOdbMBAQTGo+KtqMgR5Q84qR8QaCy+lZZ77X+o4B0/YoHWTjjFbNvq0A94QGhZrG+
         uUOzLWBM0c/HdQlpOvkPHvRGSdR5mrId1wpC5G+QvcemV6N0PDyPA03nHJwKmGhqcPZk
         qDM7oiKatUsHoQvU04WA0ABoOXLe/rUww+k1tdqyVIrGO96q8fkYf9bEQwUT4aGm5Zo7
         M39SWMatMF32oSVm2ZOS8oM2W6bmSYl3QiLpX0hL0TJ6n0SxDrQlCjJU/wMKspQvC7PZ
         oNlDUI5p4ILkunwlx769nX5p1TJBdOYT7IeFYff+6kGlC5IRhTYDWMy6ZWhEC1/donzN
         FIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725467466; x=1726072266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbNSgcdt23Q7rokBKs0uIKGlDc6DJJ/JldN4DLaNghM=;
        b=U3lBEvslou+rNRmZVOAwwkPpOo5dHp3n8pRA8E8sVmvrs/CIkULK5LqUcYKnduRshI
         xnL4MThY3wLKkmQrNRmouBjio5Ewj2KnzgkRWhHPm/QvGE15a5rryc6M+1Zp5wXF0gsy
         zVDtI34+0rvUR7zK0HHH5NMK9G3IE5HkFDEld8TOjJVJt8uY/j9/PqwUZ0TB4GLU/o03
         A93eEqM3WD2pO56CK1U1CMDin015Cpn1saHEtTh7gccdl3BeSzekBN6+DyxE9PGelvFr
         bKQdpcipXRV4y4OQkBfMrMPNzeGY/CT5LRFjBkO5laLCz6EiNMd/serD5j/6ThQa+hw3
         hp1A==
X-Forwarded-Encrypted: i=1; AJvYcCU6FHlJqB1OKDH4dCh93Y1/QOJc976wpA4AlBXizeBhSB9wOpCQcbynKgmEzN7GGVG008LMLmXPPJg47Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrd/b7bUT12BaJYFhrn5xPSId/kdIQGd4kJQQyhKhwf5aT0Ee6
	1+RNLxvQhbdMyXlQxsmeQVnRccrdrFT1aiTuRNAL4LgdKiiq3YoKXfzGm07j6fv602UmAF33NXc
	bQIsADY9Ow/Wmecn9YSlsjq/q8PFJNzTbGD6c
X-Google-Smtp-Source: AGHT+IF62n2pBXCDxyXxkgckfOehREKGzP3yBwNSv6m+Is52LgdpPKWra4hUhuMQlWJrolmrZOd2fpYLEdlvpcFXArQ=
X-Received: by 2002:a05:6402:234a:b0:5c3:c530:e98d with SMTP id
 4fb4d7f45d1cf-5c3c530ea76mr1178119a12.30.1725467465494; Wed, 04 Sep 2024
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903184334.4150843-1-sean.anderson@linux.dev> <20240903184334.4150843-4-sean.anderson@linux.dev>
In-Reply-To: <20240903184334.4150843-4-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 18:30:52 +0200
Message-ID: <CANn89iKJiU0DirRbpnMTPe0w_PZn9rf1_5=mAxhi3zbcoJR49A@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: xilinx: axienet: Relax partial rx checksum checks
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:43=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> The partial rx checksum feature computes a checksum over the entire
> packet, regardless of the L3 protocol. Remove the check for IPv4.
> Additionally, packets under 64 bytes should have been dropped by the
> MAC, so we can remove the length check as well.

Some packets have a smaller len (than 64).

For instance, TCP pure ACK and no options over IPv4 would be 54 bytes long.

Presumably they are not dropped by the MAC ?

