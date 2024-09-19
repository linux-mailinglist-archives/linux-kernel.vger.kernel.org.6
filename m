Return-Path: <linux-kernel+bounces-333770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D2997CDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEBE1F23DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7152033A;
	Thu, 19 Sep 2024 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="MSuxslZ8"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1D23759
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726771732; cv=none; b=L5ixjM/RH3VMCpaXhdA6e5VYT9hgMBiSqcjF8/N7jtu2FaK/W8qnMXmX3yum3xFu2V7rCjzTAQBz9VEB4UFv9RL620I20QanFDcKIFWDoHAmxitvWiPWRUBX1Bkjdk6NAo6r8OPYslbDMyFANF94SRKlTaUJ6mCDVXNwXi/afsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726771732; c=relaxed/simple;
	bh=tBkFsOEGKki/Ujou0mi5ka3jQDUd4rYy6dVeLu5RC6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRq9fK/4mTRKRBR+TeWQOcXzUL4PwLlR4o6g/ybEHshErJnprAmu7RwQJZmAK+BAwe+LyT6pMsiJgiED0osdwaaB2UqXb68H2FfN820tVtCV+DdpZvm0Tv3a860W0LlsMnmMecoXnWp7T1j5YjtKtQA92FKYlrpUwttDDigi1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=MSuxslZ8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374b9761eecso861527f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1726771729; x=1727376529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NKj5Iywn8pi1HV6RavjZasiS19LGez3AtSbupjyBc4=;
        b=MSuxslZ8E9y9YmWorzOb7RA3Csz+2Okf1MY9ZvOQwn1+sKSyIokoQ9ZXhP7UpHPAYW
         NOu41thxDOC6siauWBFnbk86zqlCxnFU+EY5UXLM3uUvzSGBVgcY3yWHQQQPzrhJO9sq
         DclOU6+tYc/4qXtepr8bLvlv6j8p5LstNqOnpk7cROnWS2qw6O1IsMUZ/mVQ2KsiVw78
         8/wWfXJC0De51TbrfLbv/e/shjHSp00fmCWXpLfmKCDxkvbaonhWqUF2OKz2IRlo8JFJ
         UMAI0qxgTsXwKlRpVGPhIFkRZ6gSeF8HVD5DgShbPjZ0oni6wBiQQmYZuDDUEKGq+uZU
         FfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726771729; x=1727376529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NKj5Iywn8pi1HV6RavjZasiS19LGez3AtSbupjyBc4=;
        b=a1OpY8chU5xIsNXsRnsS0f6cCtQbbrqV0QXD6StFGRoV2ELWdyVIzUXkZzM4qhvBwP
         cXDVnb9Jy5LruLBRI6DK4Uyu7q07R317BarcgtssQzCntcIcVt9ZJmR+wtyG5xIkwYyc
         F3yv5BIjWdOYe+lhBkC2Wphl7U/KvPyr+qe9nXGT+EM23Ng6Tv2nF2PTPT5pYC+IYkKo
         GuVrHjFsR0qodFBdBU3+Ka6M1EvmB0/SZvch9Ml7PSJY7bs/jawXjVA5yPOPYLtjI1XR
         k/6pw3DBjN16LJ/3gueW3XZ2/xrHyaAuHipV6oCuA/DnnXqPjlja2wxV2rWBqd4MHPqu
         +g0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWryTKpo4K0RUalV5UqVJK27BRN6WTYhZFiiiHfdQbCgcwoiVB2LGSKrUaVChATl4MOYHCH+/B9loQX9KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzdY5OiWclMCLWMXGzAzKKm1F7FkUTIgt9JgRqRxdHWNLOWeO
	VONh6SxC/NjnMPAtrz5bA0uFE/KZPemj6iCPtPdjZ09rGcBBxAX4rwhzmYbwK5H4+iCjybB/xTL
	r1UEkxGKylr1ExiqKofFTP48qoesnr+RFEPpuZ9GAshn/yg3jvK62tw==
X-Google-Smtp-Source: AGHT+IFwZ00ICb5UCjsH6ziqz8Xe7HABIip24+gKr+pPgaD0kCyAzp+K0Fw2+tCzsUPMbb7TJM5PAUtR0m7y7h5wl6k=
X-Received: by 2002:a5d:410b:0:b0:369:9358:4634 with SMTP id
 ffacd0b85a97d-37a42277e15mr193773f8f.19.1726771728546; Thu, 19 Sep 2024
 11:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919-topic-apps_smmu_coherent-v1-0-5b3a8662403d@quicinc.com>
 <D4A2FKPTXHS5.3AHU7ZEKFVMGG@fairphone.com> <2fb16b35-e6c5-4239-a745-a9dd7412539a@kernel.org>
In-Reply-To: <2fb16b35-e6c5-4239-a745-a9dd7412539a@kernel.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Thu, 19 Sep 2024 13:48:37 -0500
Message-ID: <CAKXuJqj=5wZg2+EZOmbS4TjrvqNm9UhsqeSPHZyVbOLnir_juA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Affirm SMMU coherent pagetable walker
 capability on RPMh SoCs
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Konrad,

On Thu, Sep 19, 2024 at 5:07=E2=80=AFAM Konrad Dybcio <konradybcio@kernel.o=
rg> wrote:
>
> On 19.09.2024 9:00 AM, Luca Weiss wrote:
> > On Thu Sep 19, 2024 at 12:57 AM CEST, Konrad Dybcio wrote:
> >> I only read back the SMMU config on X1E & 7280, but I have it on good
> >> authority that this concerns all RPMh SoCs. Sending as RFC just in cas=
e.
> >>
> >> Lacking coherency can hurt performance, but claiming coherency where i=
t's
> >> absent would lead to a kaboom.
> >
> > Hi Konrad!
> >
> > You want people with the affected SoCs to test this I imagine?
>
> Yeah, would be nice to confirm
>
> >
> > Just boot it and see if it doesn't implode, or do you have any more
> > elaborate test plan for this?
>
> No, booting should be enough of a test
>
> Konrad

I have tested sc8280xp on the Thinkpad X13s.  It still boots and
nothing seems to be more broken than usual (kidding, it seems to be
running exactly as it was before the patchset was applied.)  I will
try to find the time to test sc8180x on a Flex 5G as well as the
sdm845 on the Lenovo Yoga C630, but I can't promise I'll find the
time.

Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s (sc8280xp)

