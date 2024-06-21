Return-Path: <linux-kernel+bounces-223975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E6911B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCBF1F222BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2D16D318;
	Fri, 21 Jun 2024 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/rrvijN"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857C16C872;
	Fri, 21 Jun 2024 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950549; cv=none; b=ZSwx2uIAGVf1xGlfInJ9hsXxFT9g8mQFmMtTcrJQjYORXVcHIAiCHXr6EX0aMLHVvv0M0iuDuBZK7q20mZu8ISIK7dxfvKecma8X2saST+QVt/AOklS1LQn5O5CCuDFHtoKWzILq6Rzit+yxqA9sUj10dxlV8304I+9grviHN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950549; c=relaxed/simple;
	bh=7+Zay9Q/tACc3KceTusqfwoZ/lsUfeFQUleob9sKrRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAL89AA+1D05NaoWXkSEcDiHi/N0OqPbgkhnUfNAOgrsLu3d0JLH7OYSYaI3H47S+tFUKjscNed4/5tK+UYBRxOs36j2ayIQ6XKF2OUYN/DtFy706GQcYtt42qn0LKl1j+Zz2nGCzovBqEJ6XMpDYVBq3FaoxYuEcOzFL58YcfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/rrvijN; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-441567d352bso9658601cf.1;
        Thu, 20 Jun 2024 23:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718950546; x=1719555346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHjNPKqZCKhgDXLVPDuF8PC10fevxh3nwWHIDP2+EYc=;
        b=Q/rrvijN3ctZRi8/IIpYJ/+bk3ubu23W5GP+6LsqD7Wyuz/PgGabuGyURuZKdUg+cH
         C63XMtAVvKv0G8DkOxl5SSX7gXgHegF09CMxapG5u9vGT5rXWfMljOxBMlI22ZCNdFgF
         Jg6BH/ugvg0zjgkZArrkoW/H9JGq490KJ/1jO+2/GBFtOG6p/jHnhx+7qdHR/jwstaEH
         fRrDduaPerWYA6cJGF6f9+AnVPqIk8h4SjmSjIsRpwtFk5kc1f61+PnxKoCd3GNKYNR9
         nzDn6f8SAcONsYSGDiDSx2If/rTneFAZAx8DU+14F5rLke3KJEs3yOrR4TyI//yrc3YR
         g6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718950546; x=1719555346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHjNPKqZCKhgDXLVPDuF8PC10fevxh3nwWHIDP2+EYc=;
        b=b+u4lQYemTi6GOha4OSB3w2Y+h1TbJQEfTLY+eejUMGWTwYQtc88POvhWeNtxa8Odw
         Dt9T43Efi8em26k8QMy4364sWNDFv5f0XXjPr+Gs29+3pJ/CVz34dbY/iEaAYs0CXII4
         n8ota35OZfEQzjqWt/cLCuRqhmAgLAh00W5J3fEeZsNrA5VA2x8BdYqq6PSHTLmRBZu1
         yX0v4qGIcYO0xEOtnwtmWKoKNvdfUfI8HHog0K4u/7pTcPorvOC3nntNc7JU7zBrnKSR
         SOxW78XQUIveeN0JfTArntVsWFLLTJdZBhQUfCdrdc9u/nQgvk76Y/U9jyX65tukJy/L
         5ong==
X-Forwarded-Encrypted: i=1; AJvYcCVSYzQ+x3al1h6N4iiXSBkDtiGw9znBoqBUZTCZGXWHpyPjCFtXsoPvriIcf/sFBvwAWieYHrm1w/ar0Z8MNLoUII4bPUAJRHZRnR4j+1CRONWgufe+9PLtsZl0kYTANj4o+GVuYQzBlw==
X-Gm-Message-State: AOJu0YytO+WSSzDGlmHAcmgYgihpUfMhdbtn+IOUgREwQIp8i/iJ6Sj/
	AF9eMDw0P7Y4PscCIKHiHo5uY4VVZZJApcGDO978ynLiQn1eLEjxu3imIBB663OMh8nM+sJGSCb
	yru2MUOVFOvut446A0NOeHPk2oSM=
X-Google-Smtp-Source: AGHT+IE3lfFWGjWgrj27pkYkdgHBqSSalyQmDiFMb+whosNnifVr5lWmS+oKU37X0pm4Fkin2cu3+9QttEKF57F3M1c=
X-Received: by 2002:ac8:7c53:0:b0:441:58e9:678d with SMTP id
 d75a77b69052e-444a7a7344emr76740211cf.64.1718950546331; Thu, 20 Jun 2024
 23:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com> <171891591945.88443.14666251613914983261.b4-ty@sntech.de>
In-Reply-To: <171891591945.88443.14666251613914983261.b4-ty@sntech.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 21 Jun 2024 10:15:35 +0400
Message-ID: <CABjd4Yzkr22aB7v33JjXtn-4nrkL1cNmxWmb5g5KiXhnAVi0sw@mail.gmail.com>
Subject: Re: (subset) [PATCH v5 0/8] RK3588 and Rock 5B dts additions:
 thermal, OPP and fan
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, 
	linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:40=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> w=
rote:
>
> On Mon, 17 Jun 2024 22:28:50 +0400, Alexey Charkov wrote:
> > This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> > active cooling on Radxa Rock 5B via the provided PWM fan.
> >
> > Some RK3588 boards use separate regulators to supply CPUs and their
> > respective memory interfaces, so this is handled by coupling those
> > regulators in affected boards' device trees to ensure that their
> > voltage is adjusted in step.
> >
> > [...]
>
> Applied, thanks!
>
> [1/8] arm64: dts: rockchip: add thermal zones information on RK3588
>       commit: 97d61227d6bb0023a325ab2f87e4438a858207a2
> [2/8] arm64: dts: rockchip: enable thermal management on all RK3588 board=
s
>       commit: 4afa9056ed9e3d9ff036f3576cb137a011448295
> [3/8] arm64: dts: rockchip: add passive GPU cooling on RK3588
>       commit: d64d337f1856bd0e5cbfc60b6f0458ad4951d05e
> [4/8] arm64: dts: rockchip: enable automatic fan control on Rock 5B
>       commit: 2aab8905a843aef624565c014a34d155f8702135
>
>
> Don't worry, I'll look at the other patches too.
> Was just easier on my mind to this in blocks ;-) .

Great, thanks a lot Heiko!

Best regards,
Alexey

