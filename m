Return-Path: <linux-kernel+bounces-247697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA1992D351
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD31F28640A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE0193078;
	Wed, 10 Jul 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHHj/1j/"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6C12C491
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619165; cv=none; b=J0oFx+hjt5PNzPv3f1q79RnFb+Zd+0FndJzJy4UARLWAQtlfg8DHSncW/3yqMg0rwb25M5dOgzPAKvuQPFEIBBlzu+IqV27u7cJeC3/dbTCssW8nd90QUGX/GcDXkzLLn9aKX7CYtHnP4th9kxffiLWRCoJnCp7LJQVF22ZiouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619165; c=relaxed/simple;
	bh=yFybrs0fT77vAx6LB9Q+WEolILPmGGXFfxDgKNlkHBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqBn4vCSF9uiXhqNvhjJ+TXXBNVFCCFfQOSMvYz3207o0bRwCUWMC/mt2kKI52QnlnZdnut20CB5khEx4mV8OjSZDvep+NRtjUAbW4+Fw0ADxor7oJuZcxw6PXInYgUNrXg4qY9bmST2tcATctXkvJw3wdvJo68E8Nm3tve8osQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHHj/1j/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367b8a60b60so2670195f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619160; x=1721223960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuFvfAozPQGM3so90zXgathbYTyHU4zPzhPqAECnNAc=;
        b=cHHj/1j/r14lZVD+vL0/xe7s/s4gc3axSKf5aAak6zz7KVIBieVhR5AIp4yaUi8JI0
         b0yv0TC16G0DbErO3zAcS4nFnUaUekQLnWINI/O1nGIpjSXNm4XXa4vbg+0Q5DQI50Lc
         0VizIHEzceKrdQ8MRymvoEhJUrM5yL75vlwrgtOKYm37qhWcceaBWrzFqNwU84vTJ/ET
         K5QvjVICOy2MovdD0O2TbvQE1l648wNLhPAlylhp4F60Y3xm8XD4SmTPRuw7Ju1O5LQG
         Z+NJfYACGFuqzTMk9E2JAObkUaXa+uZW0i66NYkThLM3zrLrzysJ0Jc0a0KFsS+0//IV
         Oy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619160; x=1721223960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuFvfAozPQGM3so90zXgathbYTyHU4zPzhPqAECnNAc=;
        b=UXeiI6+4ugDHFtvM5iN9n+AIGuapO2/qazqTD5eGmkjpXe15WkmrMPqdAbmEKk3Oat
         LeHbgLGzySBM6lLlIgFkWje6fue+tLvJi9BKSvF3/bbxetGM7L+79xtnfqB2pdtHi/pK
         O2b0ixKsQX4RzgCuIJbFapFgixYvwj27fqGFBIWHtpZluXUq5/hA6SSPM+JFiOKk5xCu
         y5q2lEhmptIkwM1WBF0xu3XWsOwP23z7DpHpCr7sl74dh5Gcdl7k1sUfM4KBZjhXsyff
         +IzUB4rU8CXrLzg99D8AOPHjSkt+i6VvC2WtTEdCSoVGn1QegV3GxQDK2Em7VWxwna7d
         OriA==
X-Forwarded-Encrypted: i=1; AJvYcCXCaECbiESqNUGprUtyXG6JfPx0V/8Omvexd2uK5hxvuwmQArI72/jYNNljI7kaQnHkUNAPZh3EPn+AueS7pfZ0IoxrYQLdpOqyJYPs
X-Gm-Message-State: AOJu0Yx7GG/Gu4HDV3EcGP4kzbaMpd19ndKzk/ynmUZocTQMTB2bxFdy
	jLaAL5CMetHXRYCucINyNazjtpQp/nIDqEP587r/zYuPznhh4yQebtHjJWVJHIg=
X-Google-Smtp-Source: AGHT+IHRw8wRagXNh5GbODGGloMCC/O4XEq2eqQ+Yy92BqIkE1lqH7QX5XV1rVk8XN7jhfkSY5wk/g==
X-Received: by 2002:a5d:60c5:0:b0:367:4dbb:ed4e with SMTP id ffacd0b85a97d-367ce5de7c8mr3768300f8f.0.1720619160328;
        Wed, 10 Jul 2024 06:46:00 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa07dasm5336374f8f.87.2024.07.10.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:46:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com
Cc: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	robin.murphy@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf pmu: Event parsing and listing fixes
Date: Wed, 10 Jul 2024 14:45:53 +0100
Message-Id: <20240710134553.768993-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAP-5=fWVA9sEn5JbokUipRTzu24HZxxYyHGPrM5soKRb4D8_Kw@mail.gmail.com>
References: <CAP-5=fWVA9sEn5JbokUipRTzu24HZxxYyHGPrM5soKRb4D8_Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>On Wed, Jun 26, 2024 at 7:55 AM James Clark <james.clark@arm.com> wrote:
>>
>> The second fix is related to the discussion here [1].
>>
>> The first fix is unrelated but I just noticed it while fixing the
>> listing issue.
>>
>> [1]: https://lore.kernel.org/all/ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com/
>>
>> Changes since v1:
>>
>>  * Add Ian's suggested-by tag on patch 2
>>  * Fix mistake where info.pmu_name instead of pmu->name should have
>>    been used in perf_pmu__for_each_event()
>>
>> James Clark (2):
>>   perf pmu: Restore full PMU name wildcard support
>>   perf pmu: Don't de-duplicate core PMUs
>
>Reviewed-by: Ian Rogers <irogers@google.com>
>
>Looking forward to an update on the bugs in:
>https://lore.kernel.org/lkml/CAP-5=fWxdZ1ibv7Pi0L38+NF-vNWZCtcDS9JVf6k3z9nDsrQQw@mail.gmail.com/
>
>Thanks,
>Ian

Hi Ian,

Thanks for the review. I'm just finishing off one Coresight thing and
then I'll start the big.little default events one:
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/

Thanks
James

