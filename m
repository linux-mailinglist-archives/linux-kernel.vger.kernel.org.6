Return-Path: <linux-kernel+bounces-219937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E53990DA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4924281594
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D0D13D528;
	Tue, 18 Jun 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="Ymma3rvx"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8413B7AF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730678; cv=none; b=o3YocVecYVfRYRR0ZqfsUeNs3ogS/RgGluBXIrruqB6FzcgEPGHXzVrPK1M7ACUwFg0eekDdJH5obVJoHthVnSm+o79Hztf/gBvL7ZnVcvfi+oTRVOCri5y202ENnQx+ZExJhNZv0JPCCLyoxIYnjX0HMeSofhxheO3ZUyMJ2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730678; c=relaxed/simple;
	bh=jMnnhcMJpi/gTaTN/vn78bq4LGXwg9q6pMTAn83Y3F8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r15B7EtFc6WvNMcjuRI+VU/Bj7JKoBI96UcNAq5RcDgB5vbioH46zBhAeb3yC7P74HuNoLUuEAU40TiEt9XW+Nj8o3Mn9whaGrozHl/jRRxEyag3KmNJzabOit4XMdg9h0kk1O0734qER7hZ2BdOMBYuiZXTDs+YCs/oqMYsShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=Ymma3rvx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so15600f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1718730675; x=1719335475; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMnnhcMJpi/gTaTN/vn78bq4LGXwg9q6pMTAn83Y3F8=;
        b=Ymma3rvxjLGLQufPHBJM8weswvlk/cKQ6BK8KP2441o78plB07NSn+woXHAUmqyWgy
         CsVI88lBCu7M+CDpNLAfnDFoRqipB15jJZXy1rlJCia9k68Imm8rVVfQdo/5dgkfxMmT
         Cf2AAwTltOERu92Zy4StAvFn5NtRnCg3Tu/4oOvBdlHMTG18+H6UUT5goDhRk6WSwTTK
         h/+rOUKF9h0UJLNeTWlKZHmATSIULyyVtLE6c/ZERlfVMJoBzVp0oYOTffpKwp1lfMw5
         QY7HjxBGIbbJVVybYKK2yydVVRkowLhXb+0i36owJ8ZoT0RxHCd2wyd77eNRCXmI40mS
         d/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730675; x=1719335475;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMnnhcMJpi/gTaTN/vn78bq4LGXwg9q6pMTAn83Y3F8=;
        b=pvdVGCTBBxXlfkgENFl3ETh77T9g5oirwIKPJZKkXGdu3YLkEKnGWs8O7fAfi5FpgP
         +ajfXWQEtW3MU5DLhXRioS2WIvAoBrioKYgSYd2RNffxSCZl0tBA1gV2yWuvoNXemGhr
         0SgfywSt23tMg2HlyLmAGCUAb2zvCvwfMHn4LXiQoq+ZFWfdwFRkSDTAFONKSvmdb7p3
         z+qkLQNv5oquzkzmRsy3U+gPw6sVliYaZMO7k+Jh9fEa0jjrxflo5/pwfDo7VlrpupSn
         chwHRi0fBs8ZRHGW29HxlglNHna3X7fur2AoL2+IdrxjZJv1cL85UlPHWnQYmxsi2Mvm
         KD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBwcUn+iQrcH+CNodmJJI/7SgowhtgKy2QAdAY9ssF38ULXitfe9UBWbU7XwngorhZUoWkMOUnK3+mNh/ed5IenjrpINc70/Y7+U6m
X-Gm-Message-State: AOJu0YwmWHBOa+6NhriBNcZap9TWMqcSccLoGCpOA1nooH+n/KPzlUiG
	QMLpgcaCq9xV/AfLWFyUqRhP2Y11IDnQjj7yoJTll1sIZZT2R5O0T329oAL72z4=
X-Google-Smtp-Source: AGHT+IE3YLTxrz4a33OZELsomipBlbv34KTAQaWu5RA+5U74pd1KGVHNkLG+dAjkdpUc4qAC/ksT8w==
X-Received: by 2002:a05:6000:2:b0:362:363a:9594 with SMTP id ffacd0b85a97d-362363a95f1mr2284533f8f.11.1718730675351;
        Tue, 18 Jun 2024 10:11:15 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9184sm226912045e9.13.2024.06.18.10.11.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2024 10:11:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] RISC-V: Provide the frequency of mtime via hwprobe
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20240618114653.12485-1-cuiyunhui@bytedance.com>
Date: Tue, 18 Jun 2024 18:11:04 +0100
Cc: Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Evan Green <evan@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 costa.shul@redhat.com,
 Andy Chiu <andy.chiu@sifive.com>,
 samitolvanen@google.com,
 linux-doc@vger.kernel.org,
 linux-riscv <linux-riscv@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2BA519C8-D258-4D98-AD49-AC7D30D8B0D2@jrtc27.com>
References: <20240618114653.12485-1-cuiyunhui@bytedance.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 18 Jun 2024, at 12:46, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>=20
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> A handful of user-visible behavior is based on the frequency of the
> machine-mode time.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

I would suggest referring to the user-mode CSR instead, i.e. =E2=80=9Ctime=
=E2=80=9D
rather than =E2=80=9Cmtime=E2=80=9D throughout in names and =
descriptions, since that=E2=80=99s
the thing that user-mode software is actually reading from.

Jess


