Return-Path: <linux-kernel+bounces-543730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0547A4D910
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F013E7A9AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776F1FCF57;
	Tue,  4 Mar 2025 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmIgf7ma"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9483D1FDE05
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081593; cv=none; b=DNJQVb4PVHtFbYg+RVBLeeImyK7X40oJ+Gwd1IRANEAZXoV7AxkXMETVmN9VmwM3GW/MRr5TpaquX6g/8EUsrm5WOgcSvxjDpvOcB5epYi5gwtq7PyvVIpnYhUJVvPrWQq19GcKk9sPQSdxcx59HLL29HbHYipxObNw51oeXG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081593; c=relaxed/simple;
	bh=lkcrIjTkq1UIQT0SkOH+4uaD7wIEqpSNJVOOJw0jvRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkiCdGbSI6k0RxZoZGWJuUnVp0t36AgpCyh2I92WMFx9njtKrnECEuqzDg65G095yeqbjdNbVwkVZpVdmvrvQYPe+Pk3XV5JPXE7rFhi6NTuvCVcAcVve2uSJ3nmeAuEhyvR32yxJbnUFYbNSKhwZbimt/ljkx9r38brsk+LT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmIgf7ma; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e60b04fc3edso3900549276.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741081590; x=1741686390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42NUMWp1p+p6ckMbx/Ocz1ORWAedvf6DRggC3Szep3o=;
        b=AmIgf7maqmzagac5ef2fAlXpysjAYeZowCfg41F3wnuqeXXYXZv3lHHu3pRtbLAPR/
         LdjzbFCFPCArCWjdJvNh1BnKlIRT+0pWzbAvmB/EBe66Gbq1PwHXtSSLNwIgaK844dMd
         W2LqmzLU3GHI5/bA/M+pJ0218TnT9YNnrbJZ+1KlP9GgqyChSFEgHCpxv8tgVpi5Qt37
         RDwbukLmk2LTLvRZNv51PDRCu8DlMpRQMWmVdmu1fqzxEaM0SGjBsLDYHw7vAt6kmFUs
         PS+UH/NpRVpTtXtws9uYmnUyYP9TK8KxqfXs62CFMlP1bAenrOv6Fc2/sy2tAQyNZ1u+
         I9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081590; x=1741686390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42NUMWp1p+p6ckMbx/Ocz1ORWAedvf6DRggC3Szep3o=;
        b=PHKEmYjucZ/nSS0ZWKAOVQufjyGp+ZIjIWsQxwB5H5qVNaANg3f8g05FqnvM0bDiKm
         6b0gYlR4g6EkyycwVl1fGnd4xxcuoC/7LlVcqOsMKPTSjReyZ3tI8icqeb9x+zYeJs9G
         wTFxYyviJZ8JkuwMiyoYqIElLkdib2Br6SY7Ou5MZIoZPww/JVMEyzuoMSJmcJmxlD2R
         wNPwacUYOBMGAFLk+oRAQ1YKpwOaZfNAhiqVpMxLtiCuIZlqzzvNbhxasDhWxUKJIXqc
         aqUAbG1RS1+1g3NwNIU0d8rGQbZ92E/i9bo0lB0xVnSMhqT93lboNHu/QTHwlDWw459r
         Lmmw==
X-Forwarded-Encrypted: i=1; AJvYcCVG6cC4FmNPJ6Yxg2yyf1q8mmlQgtxptT8SzNZA/XibIPOCkYNo791HFycU1udZ1kaLAx6W223t4ykRrP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLA/nHTTArvI7BG7fAdYsD3hsFj9Ov2lqPQCJn+I6Q4k6c0oz
	PeJ1QOL5IKWieaXy4PKgGqUW0zkMegeWJH5C9WP3BHfqLwG7JGclMnUuA0yotVzaJOcwpBJ63v+
	VfQEDLg7Y1LEW1xA2hkCMeYTEI+rMvCkz424dXg==
X-Gm-Gg: ASbGncvCHno1KtUBOC/U0GOvYXtfiQvw/RqkrxcfaFGAnM1hTCf2fgtwCDtw6YVN+d0
	k2GWR7LQarGqgYRaKJr2RbU2aCL9avsqH+b2TRvccefE/USZ46I6y7/LQ9zZFGnX6JmrO4oN3IU
	ZhW4Tq65+yS5nJpNvU/9RyO2o5
X-Google-Smtp-Source: AGHT+IFInbqjmWLZj4CguI5UAuggpoFNnXPyCXEm68iY1s881uvIpdVSxHhbK99CylDz15ZxH6O+wYWkYQJcVjpg4TU=
X-Received: by 2002:a05:6902:161e:b0:e5d:ce4f:66bc with SMTP id
 3f1490d57ef6-e60b2f5c916mr21056408276.45.1741081590555; Tue, 04 Mar 2025
 01:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228045356.3527662-1-quic_srichara@quicinc.com>
 <20250228045356.3527662-3-quic_srichara@quicinc.com> <lakoxihaqlu3vq42eoqtlip23ggdieizotyzax5up5n6ndbwsi@ddqyzvsdtmkv>
 <1359984c-2ace-450b-a3ff-bac0b9fb5cc9@quicinc.com> <2xpu26pu4ovnchumwx7xzlp2gldpfgsurnhuqaioygb4a6xmsp@ygmpk6furqs6>
 <3e326578-ab46-4d7e-ad1e-3d572613498b@quicinc.com>
In-Reply-To: <3e326578-ab46-4d7e-ad1e-3d572613498b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 4 Mar 2025 10:46:19 +0100
X-Gm-Features: AQ5f1JrLWZmbA3L3ZWFZ6k5ZbyNJk4rnUbtfMAyZmdQl1qilIhBMnwVu8p1019I
Message-ID: <CAA8EJppXHXafwx+GPh0UhFLRLW5DNj8RwXdO4+fDdXp=SE13Uw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mailbox: tmelite-qmp: Introduce TMEL QMP mailbox driver
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, 
	manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 10:33, Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:
>
>
>
> On 3/3/2025 6:34 PM, Dmitry Baryshkov wrote:
> > On Mon, Mar 03, 2025 at 03:58:42PM +0530, Sricharan Ramabadhran wrote:
> >>
> >>
> >> On 2/28/2025 12:03 PM, Dmitry Baryshkov wrote:
> >>> On Fri, Feb 28, 2025 at 10:23:56AM +0530, Sricharan R wrote:
> >
> >>>> +          dev_err(dev, "Failed with status: %d\n", msg.resp.status);
> >>>> +          ret = msg.resp.status;
> >>>
> >>> return msg.resp.status (is it really errno?)
> >>>
> >> ok, yes error.
> >
> > The question was if it is an errno, not if it is an error.
> status != 0 is an error always.

Is it an _errno_ ?


-- 
With best wishes
Dmitry

