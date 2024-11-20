Return-Path: <linux-kernel+bounces-415595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD43F9D38BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2351F2435A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5319919DF9A;
	Wed, 20 Nov 2024 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I8IbUpIt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30661199FB2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099879; cv=none; b=FHw2/AfHl2HOsSC5DGwBQ+tyqJd+8RyWKfcJEm0p5L0ORDHoQNapp6vpCBNbwB27/CjpYJkyZpDU16LBlj82W59ZPnasEpVUobjk/CaUG5PeA83rKCAneaiNoFkIb/w7lc8vj/KsEpZfhaQoOCZy6mnknbUTiwRxBnwNjqxBU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099879; c=relaxed/simple;
	bh=VIF+FyOXBpj3sl2QYpLzeSBurqwwz5+qcTwPTBZyBPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+cPuC8XBL95nhNNlB394kpyb88YrFdL4+wNFIFNHGrSeel+WUA71AqNO0bhcRIhHJ9NCbVrhyCkmYhOc0LsL/NyXUGE+uxEA4rynCjsQNZ7eBDR/GJ4ysUfwrceA+P20Ga8qawTN9fXs3xJUBzy0Wmt1thmJi4Nte2Uop25oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I8IbUpIt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1929123e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732099873; x=1732704673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSV7n5uieMGLxmtC3IgusnUCWfo7HJvEXUUz/yMf7DU=;
        b=I8IbUpItUZ2bk7+xYmtjZXvwPrZSAQ1NANyTGib1dESYcPxTZDuX1qlyeBkXtKyZ98
         oQYmn1mVj0nQjRWkx5kavYD6aElmbkutn2pIsvJ9W4leJclqO05smMhM6kVCg0mudI06
         rXpqsrU0To1CkzzBDwh5MuUFY7AEEa3mZUXAprlWcmnC/I3pI1ZzykeIEybI26F+Vcpi
         CszLNXvhCt55fEU/Ui1ImnlzlzltgwhJm11Y2RN2Z7o5PQ0M5erZ23PahCyawtYysgem
         wqMLqL8rqAg8+GO0Eahsy8APVxic75DdF3L+aZevS50SkYEc9faw9nRhEBLbBbLczpu+
         KS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099873; x=1732704673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSV7n5uieMGLxmtC3IgusnUCWfo7HJvEXUUz/yMf7DU=;
        b=gFVfVoEsN8q2c3E5QDBiA9/h/ZfEqQkCqVWHQALLZD1lOoQgx5a/pTzv+axXDGwsj7
         RyN7Cxj7t7APNW19lWNaOyQHkn0/DwDKJE9t08GYAYrMulf5Q/EYnSYDtRcWYKV1BFao
         XdgrkKFCIDnQ2q9Uu8fbJ5lAfST5mOd8pl+ifUkq9WQ4WLVCoMlNKUlt4yNpjRnbnmGz
         rU+DgBa2n40cK/D/K+YSh5n0NG4v8qWZlhGedAabYbqNHsjoqi5jPQfBsx5AjTPgORma
         oPeQh0sZU0lYkCdVBxqr8Sbyts8+K2m5fteg4BzUfWYvJ32+Raz34wD3YO4u9Gj9ZY32
         qVHg==
X-Forwarded-Encrypted: i=1; AJvYcCUwpTIoSLyESO1q71K/UweJXYLbGlVwrmzLXVDCVhnjO8C0r8YuTFD0gP8iWmKAesL8AjcbxDxPRfaLriM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwleGWjbsWjZ5U/cb3rI/XW+71hubi6GcUO2VnUXrAMvJuom2lJ
	AAy9G6AH6c6FbYtFQc9SEEkS4NabyOBBZlpGTJvJMffmBd4OS0XPm4Yq3crb9PPxlmiy17DxyWQ
	0S7rY0UbOnhpH506A0OgrI/IHosundPGk8Aoc6Nln3nK36BrV
X-Gm-Gg: ASbGncv/Ejn/OhqsbsYVoFJfi3A7jbu0/o2Pelme/fM3QEobZylJWnjeiNFwPC54jM6
	oo4QzxB4EVIs4NuX61sAka8l4IUPfz8ufEOV18Y8tUSTVp/Vj1dvxF8VvhK89xYA=
X-Google-Smtp-Source: AGHT+IG6xl5NREy8BcJqWnYoAnnJiL7QZi758v8u/j5cG6idLf7Odlp0ZZ7OhsiP6+n70jhs7IKE2YUkjsAHV4d9P0M=
X-Received: by 2002:a05:6512:2253:b0:539:e4b5:10e5 with SMTP id
 2adb3069b0e04-53dc132785cmr944137e87.9.1732099871923; Wed, 20 Nov 2024
 02:51:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
 <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-1-7056127007a7@linaro.org>
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-1-7056127007a7@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 20 Nov 2024 11:51:01 +0100
Message-ID: <CAMRc=Mca41Ob=QzAMgz-aAhfzmBZq3=HyLr=D7_rbaZ3H5CqZw@mail.gmail.com>
Subject: Re: [PATCH 1/6] firmware: qcom: scm: Fix missing read barrier in qcom_scm_is_available()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Ojha <quic_mojha@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, Andy Gross <andy.gross@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Commit 2e4955167ec5 ("firmware: qcom: scm: Fix __scm and waitq
> completion variable initialization") introduced a write barrier in probe
> function to store global '__scm' variable.  It also claimed that it
> added a read barrier, because as we all known barriers are paired (see
> memory-barriers.txt: "Note that write barriers should normally be paired
> with read or address-dependency barriers"), however it did not really
> add it.
>
> The offending commit used READ_ONCE() to access '__scm' global which is
> not a barrier.
>
> The barrier is needed so the store to '__scm' will be properly visible.
> This is most likely not fatal in current driver design, because missing
> read barrier would mean qcom_scm_is_available() callers will access old
> value, NULL.  Driver does not support unbinding and does not correctly
> handle probe failures, thus there is no risk of stale or old pointer in
> '__scm' variable.
>
> However for code correctness, readability and to be sure that we did not
> mess up something in this tricky topic of SMP barriers, add a read
> barrier for accessing '__scm'.  Change also comment from useless/obvious
> what does barrier do, to what is expected: which other parts of the code
> are involved here.
>
> Fixes: 2e4955167ec5 ("firmware: qcom: scm: Fix __scm and waitq completion=
 variable initialization")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 72bf87ddcd969834609cda2aa915b67505e93943..246d672e8f7f0e2a326a03a5a=
f40cd434a665e67 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1867,7 +1867,8 @@ static int qcom_scm_qseecom_init(struct qcom_scm *s=
cm)
>   */
>  bool qcom_scm_is_available(void)
>  {
> -       return !!READ_ONCE(__scm);
> +       /* Paired with smp_store_release() in qcom_scm_probe */
> +       return !!smp_load_acquire(&__scm);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_is_available);
>
> @@ -2024,7 +2025,7 @@ static int qcom_scm_probe(struct platform_device *p=
dev)
>         if (ret)
>                 return ret;
>
> -       /* Let all above stores be available after this */
> +       /* Paired with smp_load_acquire() in qcom_scm_is_available(). */
>         smp_store_release(&__scm, scm);
>
>         irq =3D platform_get_irq_optional(pdev, 0);
>
> --
> 2.43.0
>
>

I'm not an expert on barriers and SMP but the explanation sounds correct to=
 me.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

