Return-Path: <linux-kernel+bounces-266640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF059403FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFF9282C41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A22CA6F;
	Tue, 30 Jul 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW5E6T7v"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9D29AF;
	Tue, 30 Jul 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722304136; cv=none; b=A6E0xXqUgmY9kzYzbFVxd8KV7Gvts45ATY2g01Yj1fKr6HoKYPhxKZeNqLD+X24g9NiKg/Hvq8spTM/yF9xIr/+Ikon1LmnulIexRAhZNs7lc1rhxvriKWl+emYaS7pqP/TUw9Z5p3paS7mzxZk/ivzeXgHR4vK38PhdLp6udqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722304136; c=relaxed/simple;
	bh=8n1996Y8lpYFOWA5Eh8nbf6QZqyqbZ6W7WJigmpON5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke/Ih2egH4MmgkCPGhuhCe/b6EVSiLUG18q5EtLGs9TQf2hQLQD4dpdcgRsPybvqaBtrs5iOeUws54kP8HUb0eWxMcZ1InWqU8/tU52sVCt0oAseHCNZJ9kucJVAWbXlaw2ihhdVV4W/dZi9+IFoIWLdkrNj9cjiF1VWDpOun78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW5E6T7v; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso2777517b3a.2;
        Mon, 29 Jul 2024 18:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722304134; x=1722908934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8n1996Y8lpYFOWA5Eh8nbf6QZqyqbZ6W7WJigmpON5M=;
        b=GW5E6T7vXiAe6IfvUY2Dce/It1eXMLZm41VcnnR75EVgcZcIPcqvBAA2eUmLc/pne7
         EImM3UxCKxVtL6Ewp3/4Z6vSfJPSNce+e3sXf3pEVg/NC5AaURzLl+ipKQHmqFt0cUqf
         /hI+yt10gdL22xZucEtqpO6Y4yWNy1raMtA0RcmNYgYFa+vcc+9DAkj9ivCblcikvnXa
         mCgGjQUXxSZBOW0yfYIOed5UJUU2PJ6kViSR50SIcWF+a2UCiHbcsnlayv10+eMrP148
         s9KhOzTagU+gE+fuIxQbr++vzkHTeHwJmRScodkyu8rCgtVzqxF13pVdogmJn+muI7YU
         8Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722304134; x=1722908934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8n1996Y8lpYFOWA5Eh8nbf6QZqyqbZ6W7WJigmpON5M=;
        b=YKSRfemQ9SP4buKMtQlYpldHC/lj/Q6zLbXPGn0hHFhPVywejSKmetFP2L14+8IS2i
         I4soVOwO5QKP3alKdrziLpbNA5HhOfg7uokjUsb9NTAsgMS1Ea37pMWu4IQYZQf4eTi1
         UpfNw+CPHNTZscQsD2UzXOUU3u/pr1BzyM5yrENqkq8BSrV2kXAppJzg4/Uj2MEqx7Ne
         F0D8P3B1j7j8DaA9u0nGaRI35ahJuzN/njvVt3HcAlQXoABP93eek1P7E/OnyaKoF7SI
         FGMteB4uZNe2/cLItreF4O2fkKIxAvJKthVOPhGQVXaagnwBIM6Y+Bt3TIzWRBdzN9G7
         azqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb7+6MlpJMjH2dpcOe0aatMgNTBboTKY5bs7MJHnKx7u9ucesVptxU6q9SRrS3X6tY0uWFC1JUCx0PvZzLZ/jLQDLUMLJr9jDUEvepOBKv3wkQ4RyMrs9v375gnc3pang5oxQC+uO6
X-Gm-Message-State: AOJu0YxKrglUbe4DU8plpE5Wy6OQOwO5eCQzejMbk5viRkizb7up9Pkt
	yI/fWvLRtlRTNSjoiSNdmMK3lJjLgoZZpW/SnOXk05ikMni+D1sV
X-Google-Smtp-Source: AGHT+IH7sIH1zweCsioW01t/maDkdbU9IGjwQFzOiWkCdl997w0ao4hui3UQ4BFfljKQfqX+6cWd4A==
X-Received: by 2002:a05:6a00:8597:b0:70b:2a:15da with SMTP id d2e1a72fcca58-70ece9facb3mr6515521b3a.4.1722304133953;
        Mon, 29 Jul 2024 18:48:53 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead890cb3sm7399127b3a.184.2024.07.29.18.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 18:48:53 -0700 (PDT)
Message-ID: <90b4bfb3-8fb1-4f77-b3e2-1c55605a8cbd@gmail.com>
Date: Tue, 30 Jul 2024 09:48:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/zh_CN: Add dev-tools/kcsan Chinese translation
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240727150844.6502-1-tttturtleruss@hust.edu.cn>
 <7670e090-92e5-48ed-9365-e611ae1d4972@gmail.com>
 <75cbc7d7-5faf-4286-a702-ac242c6f87f3@hust.edu.cn>
 <bbbc3a51-21c6-47fc-ba3e-924ad8d86b63@gmail.com>
 <CAD-N9QWBH8yZcUhSLwUCZCOBrLbS1AUONik2p5E4LWYkhyVaxQ@mail.gmail.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAD-N9QWBH8yZcUhSLwUCZCOBrLbS1AUONik2p5E4LWYkhyVaxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/30/24 9:38 AM, Dongliang Mu wrote:
>>>> "compiler instrumenting" 为什么要翻译成插桩？
>>> 指的是“KCSAN then relies on the compiler instrumenting plain accesses.”这句吗。
>> I don't understand the details of KCSAN, but according the doc, KCSAN make a array and
>> watch the data address in the array, so is there a real stub which inserted by gcc/clang?
> Yes, the compiler(gcc or clang) will insert a real stub, i.e. some
> assembly code, in the generated kernel image.

OK， then it's fine to translate like this.

