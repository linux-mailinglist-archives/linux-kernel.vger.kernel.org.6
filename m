Return-Path: <linux-kernel+bounces-442045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7F9ED751
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBAB188A1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9F225A56;
	Wed, 11 Dec 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gejs+bbB"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7E225A33
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949472; cv=none; b=fbXGVd3JzfByqjLiPw0+BBxcN/9EBP/YkDHzSqPy9k8ziqN5ybhfCjw9JIG+cj/HbTwIR8d+d8s6gEyQmBBtjcN3AEZ8tm76ccfFBMYZjMKOvIAnhrhWNCEkFn4GN03EWIUWLyEf5zlGoj2bG+10F3YlR+g9ulmroPjFxG5tzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949472; c=relaxed/simple;
	bh=py3efSUAyRMleagDedwpV2XljaINIU+e6U/z0umBLxs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=G0QdHBfm2Gp6KDEP39b18o18hOjTeikfnaPidOjRvA7DW9fyrIEvVPC3g8F1SZsYX3FeWQYQ3Mf/mJymp0/db7oH6MRrv17ic5IFrblxn5VbB8b9Lr7ORun+qegnTc1cLh7zibpGpXboLs+IMpRF25x+KzPLSlaUBdKpe49xqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gejs+bbB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434ab114753so47824995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733949468; x=1734554268; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlaSWtOv+uqBTc8ZWTohBmESKhd/YTad6Sqvxj+0fo4=;
        b=gejs+bbBIH7xBtEifsPyN7YEwSTJuxCzXsUoBzRCiio33Ymlf+BcVhInOm8OxL/xH5
         8ZGWdudPENKYgSruWg6ZauU2dgj0GH35/9cXo6DjxLGS8bCtBlSZdL9VPaNVqAqN0lMd
         MB6eZX8RT+fIwpneFjkwJLoqm6RcIwwxMhYjBf7Qk6GYj/ZGf3lya7x0m5GYFn16uXSy
         vBUCUGi6jUzlCt/04x75yfXWscZVyCPa85Ngzj4ulMw/ctlqIzBeFyb+jZKIqBlAiUq7
         g14zGq6Sm+JaIr2Ow5qCLzycGhaKJk9+/r8ZWbgOU4ohyuDPd/2v/JXMlY0S0JlJtghG
         fa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949468; x=1734554268;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HlaSWtOv+uqBTc8ZWTohBmESKhd/YTad6Sqvxj+0fo4=;
        b=F69y09hrNgygPjbnYumdFJyj8Yu+BgE93+MzZtvXp6NB+BCgZjWYQN8u04ib8+D028
         P3kDCz2J8K8qtS+Dm+ECvjw+OKz5GBkvz9Srh5ZZuVOZR8AfT9w18ncw9Uq7SloDbqJ0
         AZdUC/XEbz1rv9Uy25k3p7bUNZUU4+7nRgoAJn4NsyCCL2qAoPdw0mtKt2OkwxcYGW3Z
         WsDPzH+qJN16Al7TFENd8zm7LX5DgNtL9A8+J7T/og+C+OhJ45AQ47foG/ZsxbapGMEG
         cMMX5AHjeqSw6YYo9ajTkIFD7sHvwGrMlL0+fZmrOVSrLGhqhSICOec8hPG1P+yKHwVg
         ke6g==
X-Forwarded-Encrypted: i=1; AJvYcCXqjJOXE6rvb7IJuoEMez0goCVAjr7Jmy0U6r1q1IB2o3fuX/laBwf7jNLm/qzeTZkOWcuqdrxKiLcapLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQg2Z7fw++buB0NXYQP45YdoPpyykVjTAUOPf07TPPlgdBwtt3
	u+pO+RbLcw5e/+iWoNV+YOuIS70DxekuMNZk2YXzwguowMmpNA6K6USmPmZJyFM=
X-Gm-Gg: ASbGnctCeRC2wTmgzgcpUFceMP1KEoaBBbtL6f0hbkRtlb/lgZY3y4FvpvEEmGYYbQA
	BfR2LWsZPIIAVChcHrYAf3KY5JBau8jwHUVmdzDEFHzlHAvYeaY/tjcIAEJhUwQRn+y9VXPAtLU
	CxaJ9KFjDXg3LQINa7neGQ/CPGMoGvjzKjRkj00zjX4vgj9RCINrguMrWDo3UDCOUl6LZISZy4c
	e9ZbdQFd9/uZC98prgs1p41ZYr+DLHW2KEr+aGBxJXOWaerlOyTXBX4
X-Google-Smtp-Source: AGHT+IHMqAvhHC5dNEzt4Ji77GJgaTqFedpYNmwmOTQLG9a8yXEQAvuJOLZ9//3kNsztFbc6usJwig==
X-Received: by 2002:a05:600c:b86:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-4361c3746c2mr37514545e9.16.1733949468341;
        Wed, 11 Dec 2024 12:37:48 -0800 (PST)
Received: from localhost ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f44eaac7sm130892245e9.42.2024.12.11.12.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Dec 2024 20:37:46 +0000
Message-Id: <D695SBZSGF7W.3ONJO2E84XN0@linaro.org>
Subject: Re: [PATCH v1 03/10] arm64: dts: qcom: qrb4210-rb2: add wcd937x
 codec support
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: <broonie@kernel.org>, <konradybcio@kernel.org>,
 <konrad.dybcio@oss.qualcomm.com>, <andersson@kernel.org>,
 <srinivas.kandagatla@linaro.org>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
 <perex@perex.cz>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>,
 <linux-sound@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241101053154.497550-1-alexey.klimov@linaro.org>
 <20241101053154.497550-4-alexey.klimov@linaro.org>
 <a4z5awo6xodgjnmgrqd2hvf2ta2yhexsoyilbprz3vkimymc77@pqp3bgc2fgdh>
In-Reply-To: <a4z5awo6xodgjnmgrqd2hvf2ta2yhexsoyilbprz3vkimymc77@pqp3bgc2fgdh>

On Fri Nov 1, 2024 at 7:59 AM GMT, Krzysztof Kozlowski wrote:
> On Fri, Nov 01, 2024 at 05:31:47AM +0000, Alexey Klimov wrote:
> >  &tlmm {
> >  	gpio-reserved-ranges =3D <43 2>, <49 1>, <54 1>,
> >  			       <56 3>, <61 2>, <64 1>,
> > @@ -691,6 +731,21 @@ sdc2_card_det_n: sd-card-det-n-state {
> >  		drive-strength =3D <2>;
> >  		bias-pull-up;
> >  	};
> > +
> > +	wcd_reset_n: wcd-reset-n-state {
> > +		pins =3D "gpio82";
> > +		function =3D "gpio";
> > +		drive-strength =3D <16>;
> > +		output-high;
> > +	};
> > +
> > +	wcd_reset_n_sleep: wcd-reset-n-sleep-state {
>
> Where is it used?

Right. I'll remove it.

Thanks,
Alexey


