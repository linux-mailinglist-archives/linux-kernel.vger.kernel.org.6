Return-Path: <linux-kernel+bounces-337426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E829849FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242302832F2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D41ABEDA;
	Tue, 24 Sep 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR1UpUG1"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D561A265D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196627; cv=none; b=WlZ5QE+0GQq6zLTM7KlkTjyP6t1jkz2XRoIPr1JCIi6hs7yTnVhdXoDnQTStmIRFEDezx9mqADP4po+0knBZCXPYNTep58SiG9z8p6nH77ysPRWBXxJcReknSIPnhZ/173Pv2/kaQxE0474iA4vHryRBB0RFeGuo8/n6xxbQ/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196627; c=relaxed/simple;
	bh=TSqucCneXLlY2w5/bcNfl7wgMjyFfK9mOWImRFyUeZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnmbQa59gHCqXIpkHeHig8cPmPiEqAYG83K8Tafkc/DqclW2RfdzsAaD0ZPDkC2k5or0xG9GQPDfIPs8YMFjnB75Bg4V9GsdpLOFpUslhLfOJeKhY9FMIgyOf+6FzOZ7l1WmXGTi6jHZ2yeqhxHZlSCEhbAJ9Qm/OcGvypDJxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR1UpUG1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c36ff6e981so47290876d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727196624; x=1727801424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSqucCneXLlY2w5/bcNfl7wgMjyFfK9mOWImRFyUeZM=;
        b=bR1UpUG1FspwMkWyBzG4sWiW7Tzii6HtMzG8lZgFPS1fY7Lsa7UGyrx8ziTTkvpowt
         vLgxNx4aae1AwRHBfoLC+7VIzh4bWnvW9ZtMpwPgare8DVyAG/lEKHiC6K2o+fwjYVdu
         bGIGhaYuapQU1GctXnw0HGu3RRrnBogQRR8yS/JVGDTvdnDya7/NyJLz25te4w4ysvmF
         6xF8AElGUjULeeUg++lZY73IJNtl43iwGEIjhghyC7VQhbDgZDPxnBgasnSFZHJDh22U
         iVFh0sw64PWeWNgXyYnaxMKCalBk+7ZF5dKFcOx26HN+N/r4EM7/fPTLWgRwopXU4IlC
         EsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196624; x=1727801424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSqucCneXLlY2w5/bcNfl7wgMjyFfK9mOWImRFyUeZM=;
        b=gymC5Mn4S6RFMFr/8Bgpv7bboQtPKMTzw1OWc4sETP9UVp65fLhzXNJ7OAktHNmxux
         UFtvwtbrs31ZHiaIujiswyz92w8dJMuDMvUsHEfNtGd/YhyDCnpNmZp9ubZKWvxkWw2t
         jKu2YquFCQTO02BGrIH+qqLoWquuTk42wI0uy/VZrUq1go2wFVHejsqMkDwnGgvu5S9r
         fRT38VNlRS2Fzw0dD0LaTU5kjzSv6xVdyH+Qzo2RJrnOHJkX/HYPsq4v8Vso3hOIFX5X
         syrKgjoNo6ODJb/XOmlBEm+UillRmffrflNYHQpf0dsOwHKR7WQP8JQH45Gz0xOekgtq
         hZSw==
X-Gm-Message-State: AOJu0YzB2owgrDS9tQju/8ztjHeOrZuGArJk7hgC/FA8lDEVolqCJ+w1
	1BO5EJ95/QncsMHzW0TI+xUJhyQliRaEndwEu8z2kKF7f6TQHRcdd0oBZn2dF77BYen/1lF5O6N
	QwZEO3Xvkz9xNEyAnCHT9Xuzi6xM=
X-Google-Smtp-Source: AGHT+IF1CUbhLsOTO+WUH+jMHIcoMo99qhJHmAP2tLaOGmtMskkZA+zR52UHnBMkTFXX6RgcmVm12SXkTsSngPy1Ykg=
X-Received: by 2002:a05:6214:4a8d:b0:6c5:a41b:231d with SMTP id
 6a1803df08f44-6c7bc838547mr279717676d6.44.1727196624369; Tue, 24 Sep 2024
 09:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-3-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-3-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 09:50:13 -0700
Message-ID: <CAKEwX=Ogw3aR0McCPbdi+90U6+5u5e+-Lc41LtshTzt8q0WDVg@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] mm: zswap: Modify zswap_compress() to accept a
 page instead of a folio.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> For zswap_store() to be able to store an mTHP by compressing
> it one page at a time, zswap_compress() needs to accept a page
> as input. This will allow us to iterate through each page in
> the mTHP in zswap_store(), compress it and store it in the zpool.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

