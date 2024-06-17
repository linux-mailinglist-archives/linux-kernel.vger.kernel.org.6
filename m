Return-Path: <linux-kernel+bounces-216946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C0E90A8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F53288100
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA919067E;
	Mon, 17 Jun 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="1yhs8A8+"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152ED374D9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615024; cv=none; b=kwLuVn1ImxZLtHqfQnwSq5KVwvBD55BxIoWUmEG+eKjAPeXZk99PjVP7mUHkOO1Xb+SS+KH646IMkaXauCaMRh/h2XTlnOpO3+DYoJjqT0SXB7LXZXZnHZUwbAhP6RMwK4Uwb2QzgLZ/LaK9gd4A6Bw65wvVKXuE+veNtZ2ZSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615024; c=relaxed/simple;
	bh=nB8QMBkw+Gs0pg1mPKXuIZhWT23WrRcc+RsQ7FIMqTA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CkWo06AKhYgUMoRoO3OoImpbSp3B58e2dZkDlYipozCuaNmS4UxYX7MRBP3Y5XFJW7CKKIRZeq2TdjFWZST6BZNGWOxP3Co07Ui9Ts3kINocfmu2khRLq/PQ2dRwL0j+4A52V9I+ORFTLJ3q3kA2j0G63kuKBus2Z3WC17Cnlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=1yhs8A8+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7041ed475acso3158321b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718615021; x=1719219821; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDNdx/ptahIqYIH0Pj0xId5ttxu/lCJrKg2rnZynRFw=;
        b=1yhs8A8+yZZvqagFw3Vrduykdf38OHNEBpppN6JGgTKAQO5jpN+GX3wkcwAI/5dhlp
         J7tQL1I6a3rYY0ndIpVY6IzBE05BF0cV19rB8kr2JnAIY/ywIJg9Pp+kzFYl/NkZ/XDO
         xYtrnTeF/GHwK0b4k+uZMK1XUH6ImU+wePJLDftoME9ZKHfQL2AdoLUDCKSIp/k1wpI2
         PwTDWqjufr5TwZUfaL1s+W/SNfTzf043y6d84Fv1h2nZZiEKdrCG9cfTnFa+s1W7BXC5
         vsnKhJ6Gm1gC2pv5oQhDAgM0i/D/+5bQ7qSM3pj5+cyTh5/nOQAGoNBxshgvCKiEvQFI
         tdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615021; x=1719219821;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDNdx/ptahIqYIH0Pj0xId5ttxu/lCJrKg2rnZynRFw=;
        b=OYWs7A4AU4yDyebd1wOLdmKOhS9LQ5Gvte+L3BlHxTpaoen8TUhJVBPQ4nHl1S4g14
         OLkLcAa4niceHv7OVBqFlcrr06GFH09/0O6+/1vWIaAyRT1/tPjrQkyGJ+6qMOKyzrVU
         oVnt5oRVlcEB0GBeiIWG7QaktTruZGy1ViJnlQSRSlTYnmuVnC1Iu7CF716BpmZ4KfBV
         kZJGT+uoMFEwx2fBMJj7tjBg6cb4aWJUCau82MOg8QcFticIquKLevFNMcaHux1tQcSd
         NzyAGSAHMjhHqQwSyYhGPwQRMg599ZR98OmJU2eQUkyXP3DFpW9zROk3tDvStmlgETtA
         L87A==
X-Forwarded-Encrypted: i=1; AJvYcCVtT8lUVRLFyifLJBr8YY8x1W52SWLIrldng1DgN/8yMIbGFn70q8r1eIfUSQqS9vVnmkHa9to9IO6L2kMgbONBhMt3iqKZkqwl/wlG
X-Gm-Message-State: AOJu0YyBj0MNovoOVjIf6+JUDAM9YC4ELuvIvQBPemIiffMdFapmQ0J4
	1vFV0KRx1YqOe3rkZ8ATjFAONUDYzaQ9KjvGoUDh/yu+khI26XB0wfjtXyu/HhPMyC4lWjL6t3e
	3B+pGuQ==
X-Google-Smtp-Source: AGHT+IGl4ZLPZeK1F68wu9bXpVDKybvPNImmW3ohNbywjyE4zel7t83lUzZALw6c8pEDGKdWBPKXzg==
X-Received: by 2002:a05:6a00:8d5:b0:704:32dc:c4e4 with SMTP id d2e1a72fcca58-705d7123929mr11639890b3a.1.1718615020941;
        Mon, 17 Jun 2024 02:03:40 -0700 (PDT)
Received: from smtpclient.apple (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf36aa1sm6270503a12.17.2024.06.17.02.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:03:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] scsi: sd: Keep the discard mode stable
From: Li Feng <fengli@smartx.com>
In-Reply-To: <Zm_U_ZA96u2K6a6S@infradead.org>
Date: Mon, 17 Jun 2024 17:03:03 +0800
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44BCFE4F-AB66-4E6A-A181-E7D93847EF98@smartx.com>
References: <20240614160350.180490-1-fengli@smartx.com>
 <Zm_U_ZA96u2K6a6S@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3731.300.101.1.3)



> 2024=E5=B9=B46=E6=9C=8817=E6=97=A5 14:17=EF=BC=8CChristoph Hellwig =
<hch@infradead.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, Jun 15, 2024 at 12:03:47AM +0800, Li Feng wrote:
>> + /*
>> + * When the discard mode has been set to UNMAP, it should not be set =
to
>=20
> Overly long line here.
OK.

>=20
>> + * WRITE SAME with UNMAP.
>> + */
>> + if (!sdkp->max_unmap_blocks)
>> + sd_config_discard(sdkp, SD_LBP_WS16);
>=20
> But more importantly this doesn't really scale to all the variations
> of reported / guessed at probe time vs overriden.  I think you just
> need an explicit override flag that skips the discard settings.
>=20
I think we only need to prevent the temporary change of discard mode=20
from UNMAP to WS16, and this patch should be enough.

Maybe it is a good idea to remove the call to sd_config_discard=20
from read_capacity_16 . Because the unmap_alignment/ unmap_granularity
used by sd_config_discard are assigned in sd_read_block_limits.=20

sd_read_block_limits is enough to negotiate the discard parameter.=20
It is redundant for read_capacity to modify the discard parameter.  In =
this way,=20
when the SCSI probe sends read_capacity first and then read block =
limits,=20
it avoids the change of discard from DISABLE to WS16 to UNMAP.

Thanks,
Li=

