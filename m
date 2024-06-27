Return-Path: <linux-kernel+bounces-231898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87A91A00D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A25282E74
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0C47A5C;
	Thu, 27 Jun 2024 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdZoC7Uf"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD024317C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472170; cv=none; b=i4Zqbya+a9/s36v+uys5O7hwFDdUICpP7b6gV3gd0WzsblVDtZfuNH9MdiWuTvTTbzKoyc6ecfwZbe2vxUWRYTRlhAAxjImk/RCcaNzqwjwBYgBrHaIScX8svVtJqDTZ1ovAJrpLZPzTsrRsrxrvUeI7MLNyPPSZVpdd5EP7bpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472170; c=relaxed/simple;
	bh=TxLTIeySqAl4h7rFui0gAWddDVqf1uijpQjdo7VXnOg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bF4CTL7t4LapnFw74cHbEeZ4cpNYQ+jZZ/y8lkWAeI2ZbTw1gzqx/ovNZZhEgyUaaPn1zG5LW2EnDLs4zGhxhvZ1pkSeQLXud3VIK9ISBXkXLqfaDbcDK19ADXBmZpGzpWQ18EBO8Gl9Wx5db/Hmlxs6Zfc/gYivmcrNVfU2lnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdZoC7Uf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a724b3a32d2so571011166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719472167; x=1720076967; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxLTIeySqAl4h7rFui0gAWddDVqf1uijpQjdo7VXnOg=;
        b=ZdZoC7UfqAl/lKhKB9A57QkW5O3cTlOAgDHECZmpNpx+TrqGe5twV+U8G578BVFTO0
         yeXxS+M6Iy1Qw03eyXjC/ghC/A/gVcc8glceSj1ovwPtHbrTcIVGpqkTnSKYiy1rc2x5
         RCPll/lnEQE7y2hEAY9BBUT67WNm1KSUKASFXVc0lCZY7qBU9mr5UbHjbKMjkDNBuVbt
         JqOUalpCvvk+E3AXUqTS6X/K7O8l8sjkl6inPvjtLGBiJrwVnrDXYLE4pfnzsbQvSJJx
         0uzcCWIpsgBXtqONN30QUM13W++72nfCgoiPE3QV36c/w3eQoxvLOtXoeFxzLsUsvrtX
         eCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719472167; x=1720076967;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxLTIeySqAl4h7rFui0gAWddDVqf1uijpQjdo7VXnOg=;
        b=bDoJRI0O1OrHxg1sX9IoClhZdVirSlfuLYvuW2cRAEDAolbdW3wOU7ZfmdM0jhAqZc
         BtbtsY9q/Xw/C+KHpo8qTtAMXesfd0Qw146gPhIDZaIOccob0eeclPxa3q1DVraIk9Ha
         zRrpZwiWFAzAD/8o40ISMR0cAEbAmIAAx08TfaysODEXNc4uXDR/fl89gznjsKOx6AIL
         OhyhdfiuklzA2xlSI4xOjiSuIIUjefx2wFi2K/UsQiTDAixgQaE7K6sMLrlxU9btaTd7
         TctYCy26b6huDkyfow8TV0J3AFs+cHTALL+U01mI3fhGPGkrICdy43LMSi+hIRUn5obH
         DaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqllHi0ZNfs60/JiClpgs/pxfu/VhSL/BCEfVA48gwW+UzaFnPtgr56QcBKsYuBYA0IuV1F+cJ1zvKW3Cw4lq6JPaWFPxJbEbRkJHu
X-Gm-Message-State: AOJu0YwmC0yYFuwZtHTK/77wstGGnorD+OGOq4cIpv88u/WraBzgNLJz
	lqnN+l4cj0Vf6UlItZyBIxl0gHcLwBS8cK7C6tdWkwaHwI5vs67lheK020uhDPo=
X-Google-Smtp-Source: AGHT+IG6EzT1XuDdZg5M0qT3q6rt5bL6uHWfiJ17Qg5sb12SSaMyivudDrsR6pH8Uy3nBzB0OAZTMg==
X-Received: by 2002:a17:907:d508:b0:a71:40d4:b1d7 with SMTP id a640c23a62f3a-a727f84fe6fmr416337866b.56.1719472167225;
        Thu, 27 Jun 2024 00:09:27 -0700 (PDT)
Received: from ?IPv6:2001:a61:359b:e801:d44:32b3:6924:10d1? ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d7b531esm30786966b.162.2024.06.27.00.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 00:09:26 -0700 (PDT)
Message-ID: <12f9a0000b758ba7b9272657e521445247337539.camel@gmail.com>
Subject: Re: [PATCH v2] mux: MAINTAINERS: change ADGS1408 maintainer to Nuno
 Sa
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nuno Sa
	 <nuno.sa@analog.com>, Peter Rosin <peda@axentia.se>, 
	linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 09:09:26 +0200
In-Reply-To: <20240627070512.6577-1-krzysztof.kozlowski@linaro.org>
References: <20240627070512.6577-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-27 at 09:05 +0200, Krzysztof Kozlowski wrote:
> Emails to Mircea Caprioru bounce:
>=20
> =C2=A0 Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound;=
 Recipient not
> found by SMTP address lookup'
>=20
> and Nuno Sa offered to keep maintenance of this driver.
>=20
> Link:
> https://lore.kernel.org/all/8a3ac03fcdc5c2c6401d0a990af5d6e9f6c6670d.came=
l@gmail.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Thanks!

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



