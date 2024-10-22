Return-Path: <linux-kernel+bounces-375749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19349A9A52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D319B21469
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BD21465B1;
	Tue, 22 Oct 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Neb/fi2y"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A6811F1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580245; cv=none; b=RtpM4PStWVU7VqiuRW9P+3+FQOQKMFfWagjeLXdMmaEidmgzl8OcZQK5Hv+gDwT1Up1r9eMphCBaC6ERW5hc0ny1Up+mnDfq3yr5QcXwVAM88Iuugcp+5+xTRfF7d9qRW672unhRbVlyqaEr/2POgjmW5Jwzpx1ujhGJ/g1oV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580245; c=relaxed/simple;
	bh=cxGSevfjqIssyM5bsmKvrGQ9UdYKa3i8NiO5ITLhZ40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R95Vwvwi46EByqKHX2bEPxt5n9Nks5g9jQbPjLPH/3Hoijy8bPf6YP/lAlrOYMH8Bz6Q+j8mc923RwjahylGkWF2UtrEgTddvxlgGfa/tuqsrH5E8CT06rTexI5MM1BCI95pBbkhAkKrLa2VxEzX3y6yrmnWNSaWdoEQNuiLDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Neb/fi2y; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e2e3179b224so110133276.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729580243; x=1730185043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRrFt/KPQCPYuot/0PuPd+VWwguSgMsl8ZS8aWe8ttg=;
        b=Neb/fi2yqncU6qijKcXqw8tAqnolKQypIAMHRAmYYl/4pSKXTPGSs0QJt3PLldEQuk
         PUE+hhsc1udCWop4kLSZMPFpgzpex/969pegPVV5wDWL3jRqDR11UDz1sLrbLbIuPCrF
         cAUh9GDzv8X5zcMGvSl8tEGZv++QxivVpaFAiDKN9RR5OA3dN/ufIF0XF20sTy1c9Gp/
         68juSldxuSiYUfb+YYV2WWUY4bWacm5fr9qG3rVnTdmu6dBIXgRl89oi6hkaYpSHlwq7
         mfu4/5NztwjeBSfCXOR9faj3ywjADXwmIkuydOn+UXa2C0nOqYxiZHu1aW9Ymh1Nc2N8
         VEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580243; x=1730185043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRrFt/KPQCPYuot/0PuPd+VWwguSgMsl8ZS8aWe8ttg=;
        b=VzkGOSfRs69CPwv2FHyZXQDUo5fsw6AM9Z81BeQxKOTr6Ajawa3/jWtUTtdr9njfHJ
         VKCJQKjFl+70VHQf88Zsql6ohc4GPsBbe43HOeC2a2lTRlACqX3RVEROM42tjTG0wXD8
         d8DrGWfAiHhTlLHKOT0vRup+q6rYCGA3l9BXvhmsgfr8i9iaS8FC5Sq9R879PtwoZzQ9
         CEjbFQ9r7y2SZt7CZCBUywjEl4U+aV6PY7J9VCY0QE47O632HkZiadyi4zlCNjFRU7fX
         UGTXnHL8PhKYJwmpfyMeWRyARnGXXvfX3s4sWKVLE0QdmRW9w2svptn8fKeyvligGeMu
         K8PA==
X-Forwarded-Encrypted: i=1; AJvYcCVYntry+/3e/SNgqzeN1vxuxjv7a5C/mDLG6Y3UAEvJP6sEgwL6MOiS9+bmenQBFTfWj2FioA4h40/6X1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysM1zW76w5JhNch0lK0of9qupghrDP2RIyUMJsN1c+EBbh0fia
	QdNoMgjeR0JJShIXMq1VizPyJXronZ7eihnIeeAFhr7MmUHSJqnDlX1KgBX5R/+VxmZgaRFk4Ob
	Z1JLqUHvF3e7//3K10mbTF4zHqgdYV+wMMExsiQog9ujM91TX+hc=
X-Google-Smtp-Source: AGHT+IGumwlow4+q+ipOXyKpmyqgzRnQiLYo1bfjvDXtBX1Ew+kvKaqJy3bMjv7NqYbIbgNW4CB+3q43o8HgvvAp2K4=
X-Received: by 2002:a05:690c:490b:b0:6e3:d5ac:7d59 with SMTP id
 00721157ae682-6e7d3c17f36mr22941727b3.45.1729580242899; Mon, 21 Oct 2024
 23:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014111527.2272428-1-quic_kuldsing@quicinc.com>
 <20241014111527.2272428-3-quic_kuldsing@quicinc.com> <CAMRc=MfR8rK3EnZx3_9rxkwgv6f8jA4X0u0cGBkpJ89d5i1MKw@mail.gmail.com>
 <f46a9180-ca71-458e-9693-ed9badc85e72@quicinc.com> <21630547-552b-43e0-906f-840610327876@quicinc.com>
In-Reply-To: <21630547-552b-43e0-906f-840610327876@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 22 Oct 2024 08:57:12 +0200
Message-ID: <CACMJSeuM=xmtvJr_DOZNdsj6FpF50xgXx1VED4OW6cv=s2qW5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] firmware: qcom: qcom_tzmem: Implement sanity checks
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 at 07:43, Kuldeep Singh <quic_kuldsing@quicinc.com> wro=
te:
>
>
>
> On 10/16/2024 2:31 PM, Kuldeep Singh wrote:
> >
> > On 10/14/2024 6:38 PM, Bartosz Golaszewski wrote:
> >> On Mon, Oct 14, 2024 at 1:19=E2=80=AFPM Kuldeep Singh <quic_kuldsing@q=
uicinc.com> wrote:
> >>>
> >>> The qcom_tzmem driver currently has exposed APIs that lack validation=
s
> >>> on required input parameters. This oversight can lead to unexpected n=
ull
> >>> pointer dereference crashes.
> >>>
> >>
> >> The commit message is not true. None of the things you changed below
> >> can lead to a NULL-pointer dereference.>
> >>> To address this issue, add sanity for required input parameters.
> >>>
> >>> Signed-off-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> >>> ---
> >>>  drivers/firmware/qcom/qcom_tzmem.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qc=
om/qcom_tzmem.c
> >>> index 92b365178235..977e48fec32f 100644
> >>> --- a/drivers/firmware/qcom/qcom_tzmem.c
> >>> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> >>> @@ -203,6 +203,9 @@ qcom_tzmem_pool_new(const struct qcom_tzmem_pool_=
config *config)
> >>>
> >>>         might_sleep();
> >>>
> >>> +       if (!config->policy)
> >>> +               return ERR_PTR(-EINVAL);
> >>
> >> This is already handled by the default case of the switch.
> >
> > Ack. Need to drop.
> > https://elixir.bootlin.com/linux/v6.12-rc3/source/drivers/firmware/qcom=
/qcom_tzmem.c#L218
> >
> > While examining qcom_tzmem_pool_free under the same principle, it
> > appears the following check is unnecessary.
> > https://elixir.bootlin.com/linux/v6.12-rc3/source/drivers/firmware/qcom=
/qcom_tzmem.c#L268
> >
>
> Bartosz,
> I am thinking to remove below check in next rev like mentioned above.
> https://elixir.bootlin.com/linux/v6.12-rc3/source/drivers/firmware/qcom/q=
com_tzmem.c#L268
>
> Do you have any other opinion here?
> Please let me know.
>

No, let's keep the NULL-pointer check and add it to qcom_tzmem_free(),
I'm not against it. I was just saying that in the latter case it will
already be handled by the radix tree lookup.

Bart

