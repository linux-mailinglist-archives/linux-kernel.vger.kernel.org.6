Return-Path: <linux-kernel+bounces-183812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D068C9E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CCFB22475
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779D13667E;
	Mon, 20 May 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1MKI1te"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F52136658;
	Mon, 20 May 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213492; cv=none; b=lYkQYBVLDRZybzu2OudOZGYqeDIsU9+csiQ0Ov69590KSMmu0oNcIwW0UEgOifYIFh2KNWMLQQ1Bb9PnF+9Hd8mCo2ihmcSi6VdmyzZmz5kSdzk2KenAN59vpT+6ZUy8XtNYmgsuAITzmPTUrFC/Z0B2dyrBwacd115gJPMTu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213492; c=relaxed/simple;
	bh=4XRyKsv+ktKwEMFWCnR0/ki044xhY4Tvtdof1cxypnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ge7B+pXUCHY2TwS8SOY66HCRUDUaAlbiD0xiY3ht43wezyMwTLgjiZEQ4FJt0tVhtErgYk37nftyNSoWGLuDoybMHivNu/phxYfnis7FORbEm9/xLvRw4ieEp2zC3fkzkIQsvjSCKodbA5uTsfvKQWgDA8h0QrYwn+ZUEonFkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1MKI1te; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee954e0aa6so43462675ad.3;
        Mon, 20 May 2024 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716213490; x=1716818290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aK2KfWsY9tIOekL8pJv9CCEv+WbW12jE+CdMrD20bkQ=;
        b=U1MKI1teuzIQ8BbZzZvTI2O3gwfrbQ9Vo3WWfwFfjXjluAB9UySAqvMvxdca5eEC9U
         WFgP8foh1MuuwKF1HwThZRRqOwyEmOobEa+aVO1B/XVP9z81H4Y5xFWsr7BhXIzx/IlI
         MntTSpN8krJxyLPy39imosJ1DyinplJ2FEXMlI/nqPK5qDD7K6/DdqpY3DtTD7y4qVQ7
         TKlFQFFERjihPExnlT7C+HdTTC2UamjW3kq2Y/e3wi+8O9r1DEc80o9UrNjXcsf1kI9u
         EdRK4cwGHTNaeFZN9zqBpD4NeCe0zWVV3O2KBfs++jA9QVK/hnmbBiiADwGpKz0XnwHQ
         DlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716213490; x=1716818290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK2KfWsY9tIOekL8pJv9CCEv+WbW12jE+CdMrD20bkQ=;
        b=GSIsfO3X75FRyGEj7wDHLpzJ9Ohfo6shGvjmEuOibU5FX7gOGwHIdM4qdi9IU5/rBx
         7gvjyKU6YbfbzD1fdvyNxeUIuXZ6I0NQGEQkpMc45wtKg35Voe0H5xCdVDkV+NCa5tsf
         mWeNUT4eBY4WDqLM9btzBdIDxaa4BCZLANkrEIySqTbXIv2Cq/gjnJky5gW9qALke6/T
         p/1Djylb25VpyWbA6urSaJ57rB82xqYVLzauDqnktLvd9esY34XSXjfD0EQ16hhc7mIM
         salSnrDQyduolopE7jQNSgNWXhYbQcEX0t48oaEF380N9b/ITIczxXEBF3EDObWvD6Wa
         eajw==
X-Forwarded-Encrypted: i=1; AJvYcCXxljLKNOhw07rty0+zofUmexhBUz+CiflaR2i6fCF0PSTFAsb14127wPd6Y+EdwpzUwxqTPfAP0foJGyBe49EJwxBYIe0825yrEQ2aF9owqd1sfxP7sG3tHuP8G7FnSuG6mhl05HnOTC/hFzLHJQSJdOA/wMv7jOtQoAugTdC1l2uP
X-Gm-Message-State: AOJu0Yyq1mGUYvQuEQRr+nlx5diRB6YxQ6WVJmqYHPaW2qRwiNyaLnhY
	lLqknRaxeBbCYOvXQc73XfBBgiC7vA7VptUbmTd0ybz3XkAdgrAU
X-Google-Smtp-Source: AGHT+IH6bOQxKKfz2oRDMwLwhzxzcoFHDDbYI/j24IRoy5TIbufIXanD7RPTZ6YTXUM1epUFeAxFew==
X-Received: by 2002:a05:6a20:3c94:b0:1ad:7bfd:54a1 with SMTP id adf61e73a8af0-1afde0e2402mr29348300637.17.1716213489954;
        Mon, 20 May 2024 06:58:09 -0700 (PDT)
Received: from [10.59.0.127] ([210.178.66.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b254cfsm19098701b3a.200.2024.05.20.06.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 06:58:09 -0700 (PDT)
Message-ID: <fcbaeb18-41ce-47c2-8914-96345449a280@gmail.com>
Date: Mon, 20 May 2024 22:58:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cve Korean translation
Content-Language: ko
To: yskelg@gmail.com, Jonathan Corbet <corbet@lwn.net>
Cc: Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240511195942.30857-1-yskelg@gmail.com>
From: Jinwoo Park <pmnxis@gmail.com>
In-Reply-To: <20240511195942.30857-1-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024. 5. 12. 오전 4:59, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> This is a Documentation/process/cve korean version.
> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>

Thanks for translating new Documentation/process/cve document to Korean
Language. Most of the Korean sentences are looks good to me. But only
one sentence seemed unnatural.

> 잘못된 CVE 항목들
> =================
>
> -해당 배포판에서 변경된 사항으로 인해 또는 해당 배포판이 더 이상
kernel.org
> +특정 배포판에서 변경된 사항으로 인해 또는 해당 배포판이 더 이상
kernel.org
> 지원 릴리스가 아닌 커널 버전을 지원하기 때문에 Linux 배포판에서만 지원되는
> Linux 커널에서 보안 문제가 발견되는 경우 Linux 커널 CVE 팀에서 CVE를 할당할
수
> 없으며 해당 Linux 배포판 자체에서 요청해야 합니다.

When the first modifier "해당" is first used in a Korean sentence, like
"the", there needs to be an explanation of what it is targeting.

However, in the process of literal translation, it seems that "the"
became "해당" due to the difference in word order between Korean and
English, And since the translated sentence did not describe which "Linux
distributor" is being described, it would be very difficult if
"특정(specific)" were used instead. It seems natural.

> ---
>  .../translations/ko_KR/process/cve.rst        | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst
> 
> diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
> new file mode 100644
> index 000000000000..26682969b2b7
> --- /dev/null
> +++ b/Documentation/translations/ko_KR/process/cve.rst
> @@ -0,0 +1,107 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Original: Documentation/process/cve.rst
> +:Translator: Yunseong Kim <yskelg@gmail.com>
> +
> +==========
> +CVE 항목들
> +==========
> +
> +공통 취약점 및 노출(CVE®) 번호는 공개적으로 발표된 보안 취약점을 식별, 정의 및
> +목록화하기 위한 명확한 방법으로 개발되었습니다. 시간이 지남에 따라 커널
> +프로젝트와 관련하여서는 그 유용성이 감소했으며, CVE 번호는 부적절한 방식과
> +부적절한 이유로 할당되는 경우가 매우 많았습니다. 이로 인하여 커널 개발
> +커뮤니티에서는 이를 기피하는 경향이 있었습니다. 그러나 커널 커뮤니티 외부의
> +개인과 회사가 CVE 및 기타 형태의 보안 식별자를 할당하라는 지속적인 압박과
> +지속적인 남용이 결합되면서 커널 커뮤니티가 이러한 할당에 대한 통제권을 가져야
> +한다는 것이 분명해졌습니다.
> +
> +Linux 커널 개발자 팀은 잠재적인 Linux 커널 보안 문제에 대해 CVE를 할당할 수
> +있는 권한이 있습니다. 여기서 할당은 :doc:`일반 Linux 커널 보안 버그 보고
> +절차<../process/security-bugs>`와는 별개입니다.
> +
> +Linux 커널에 할당된 모든 CVE 목록은
> +https://lore.kernel.org/linux-cve-announce/ 에 있는 Linux-CVE 메일링 리스트의
> +아카이브에서 확인할 수 있습니다. 할당된 CVE에 대한 알림을 받으려면 해당
> +메일링 리스트에 `구독
> +<https://subspace.kernel.org/subscribing.html>`_ 하세요.
> +
> +절차
> +====
> +
> +일반적인 안정 릴리스 절차의 일부로, 잠재적으로 보안 문제가 될 수 있는 커널
> +변경 사항은 CVE 번호 할당을 담당하는 개발자가 식별하여 CVE 번호를 자동으로
> +할당합니다. 이러한 할당은 linux-cve-announce 메일링 리스트에 공지사항으로
> +수시로 게시됩니다.
> +
> +리눅스 커널이 시스템에 있는 계층으로 인해 거의 모든 버그가 커널의 보안을
> +손상시키는 데 악용될 수 있지만 버그가 수정되면 악용 가능성이 명확하게 드러나지
> +않는 경우가 많습니다. 이 때문에 CVE 할당 팀은 지나치게 조심스럽게 버그 수정이
> +확인되는 모든 버그에 CVE 번호를 할당합니다.
> +이것이 리눅스 커널 팀에서 발행하는 겉으로 보기에 많은 수의 CVE를 설명합니다.
> +
> +사용자가 CVE를 지정해야 한다고 생각하는 특정 수정 사항을 CVE 할당 팀이 놓친
> +경우 <cve@kernel.org>로 이메일을 보내 주시면 해당 팀에서 함께 작업할 것입니다.
> +이 별칭은 이미 릴리스된 커널 트리에 있는 수정 사항에 대한 CVE 할당 전용이므로
> +잠재적인 보안 문제는 이 별칭으로 보내서는 안 됩니다.
> +수정되지 않은 보안 문제를 발견했다고 생각되면 :doc:`일반 Linux 커널 보안
> +버그 보고 절차<../process/security-bugs>`를 따르세요.
> +
> +Linux 커널에서 수정되지 않은 보안 이슈에 대해서는 CVE가 자동으로 할당되지
> +않으며, 수정이 제공되고 안정적인 커널 트리에 적용된 후에만 자동으로 할당되며,
> +기존 수정의 git 커밋 ID로 추적할 수 있습니다. 커밋으로 문제가 해결되기 전에
> +CVE를 할당받고자 하는 사람은 커널 CVE 할당 팀<cve@kernel.org>에 문의하여
> +예약된 식별자 항목들에서 식별자를 할당받으시기 바랍니다.
> +
> +현재 Stable/LTS 커널 팀에서 적극적으로 지원하지 않는 커널 버전에서 발견된
> +문제에 대해서는 CVE가 할당되지 않습니다.
> +현재 지원되는 커널 브랜치 목록은 https://kernel.org/releases.html 에서 확인할
> +수 있습니다.
> +
> +할당된 CVE 항목들의 분쟁
> +=========================
> +
> +특정 커널 변경에 대해 할당된 CVE에 대해 이의를 제기하거나 수정할 권한은
> +전적으로 영향을 받는 관련 하위 시스템의 유지 관리자에게 있습니다.
> +이 원칙은 취약점 보고에 있어 높은 수준의 정확성과 책임성을 보장합니다.
> +하위 시스템에 대한 깊은 전문 지식과 친밀한 지식을 갖춘 사람만이 보고된
> +취약점의 유효성과 범위를 효과적으로 평가하고 적절한 CVE 지정을 결정할 수
> +있습니다. 이 지정된 기관 외부에서 CVE를 수정하거나 이의를 제기하려는 시도는
> +혼란, 부정확한 보고, 궁극적으로 시스템 손상으로 이어질 수 있습니다.
> +
> +잘못된 CVE 항목들
> +=================
> +
> +해당 배포판에서 변경된 사항으로 인해 또는 해당 배포판이 더 이상 kernel.org
> +지원 릴리스가 아닌 커널 버전을 지원하기 때문에 Linux 배포판에서만 지원되는
> +Linux 커널에서 보안 문제가 발견되는 경우 Linux 커널 CVE 팀에서 CVE를 할당할 수
> +없으며 해당 Linux 배포판 자체에서 요청해야 합니다.
> +
> +커널 할당 CVE 팀이 아닌 다른 그룹에서 적극적으로 지원되는 커널 버전에 대해
> +Linux 커널에 대해 할당된 CVE는 유효한 CVE로 취급해서는 안 됩니다.
> +CNA 수정 절차를 통해 해당 항목을 무효화할 수 있도록 커널 CVE 할당 팀에
> +<cve@kernel.org>로 알려주시기 바랍니다.
> +
> +특정 CVE의 적용 가능성
> +======================
> +
> +Linux 커널은 외부 사용자가 다양한 방법으로 접근하거나 전혀 접근하지 않는
> +등 다양한 방식으로 사용될 수 있으므로 특정 CVE의 적용 여부는 Linux 사용자가
> +결정할 사항이며 CVE 할당 팀의 권한이 아닙니다. 특정 CVE의 적용 가능성을
> +판단하기 위해 우리에게 문의하지 마시기 바랍니다.
> +
> +또한 소스 트리가 매우 방대하고 어떤 시스템도 소스 트리의 작은 하위 집합만
> +사용하므로 Linux 사용자는 할당된 많은 수의 CVE가 자신의 시스템과 관련이 없다는
> +사실을 알고 인지해야 합니다.
> +
> +즉, 우리는 사용자의 사용 사례를 알지 못하며 사용자가 커널의 어떤 부분을
> +사용하는지 알 수 없으므로 특정 CVE가 사용자의 시스템과 관련이 있는지 판단할 수
> +있는 방법이 없습니다.
> +
> +항상 그렇듯이 커널 변경 사항은 개별적으로 선별된 변경 사항이 아니라 많은
> +커뮤니티 구성원이 통합된 전체에서 함께 테스트하는 것이므로 릴리스된 모든 커널
> +변경 사항을 적용하는 것이 가장 좋습니다. 또한 많은 버그의 경우 전체 문제에
> +대한 해결책은 단일 변경 사항이 아니라 여러 수정 사항을 모아놓고 보아야 찾을 수
> +있다는 점에 유의하세요. 이상적으로는 모든 문제에 대한 모든 수정 사항에 CVE가
> +할당되지만, 때로는 수정 사항을 발견하지 못하는 경우가 있으므로 CVE가 할당되지
> +않은 일부 변경 사항이 관련성이 있을 수 있다고 가정합니다.

