Return-Path: <linux-kernel+bounces-511373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99BA32A16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0E167FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4869D212B11;
	Wed, 12 Feb 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0rRetQj"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442020ADF0;
	Wed, 12 Feb 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374256; cv=none; b=GmOqA0uxSSWWdT0Ze/58Fg1GkR6HFAlTDYllVJFlIptFByVO4AtDAVZfP5Z7QRFhZ8gglK0Kldn8eQwsur/RnGZDQ9ijrBUGMj7XRT2a7fJSiYUzZCSk0rJH1jOE2Szjy+vBoLJ07zdFpuwlvkPMDkSMjP3JVHGUBfIICkFFa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374256; c=relaxed/simple;
	bh=MAtG92N2SWjCdRryDPNdzwAzb02UYJSpVQXAEY3WMCM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BD0bzgBnH3P2Jo/Y1wdqzdyA1QMP1mA+jtPzuFnLZ9nzzrb9a9N6Mozw/Hib2VaEpBtUG+ZYd0D28D/9oVg4FoP6GT/JzrRgURrt3hN1cLrrLFIi/xKsrQ7vT3m6VkOvN9rWSLnPVRLXOCeknBEkToVGVoL6oRQIoccFNBh28hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0rRetQj; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3d3bdaf01so152998b6e.2;
        Wed, 12 Feb 2025 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374254; x=1739979054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DcoanOKitVezBpiIfANSna0p0JOi+WIjBSEV3ZOS7zU=;
        b=j0rRetQjE71coigVNZsomO1WqueGJulv5atq6E9pTkdkulcgitVlmlrfQh6ONCN5bQ
         g7MP+TdzDu2AbJRqtKCCrsr4oFBxdFib8FQb1+H99HODRzjjNSa3YGz8/kPBUV6whTHZ
         b8zhuR/DkLlo2LQgPiiThKTNjJ0kuDSJW+yCPSVDST1d6JOd5aoUUktkM6M1knEifm0+
         c7oMjCU9fOkTMnuVi0k3RWO4gOj1/mRxtNhyNjYU0DsiihsQ65eP/+khvgtj1qfK0oyf
         7juJQXAxuRgcRvP1WnNFyrmDBZF4sfhPh7jOmM8Q3we0GxxqZxv6hznMiE+wNIJWo4lH
         1MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374254; x=1739979054;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcoanOKitVezBpiIfANSna0p0JOi+WIjBSEV3ZOS7zU=;
        b=mCH/TrMEXNkx/+v8lHpY0gO82j9xJMrXiXz7tmYvHYGCvvvftKfBHhx1ZmF7NsMo6x
         yeLLg5N9iJW7buFWo6JUfGGBkJxMFYheEF5uPhT4dlqCHmVHPjzsIvL/uA1WprsbhvlL
         SfbKvtmmCiEnTtceaWmA4LCl+/MEMxNCc6xteTCUeqxBmyTHxyY1U4pGKyAmV9V79O3F
         AEWAh286lv1TidrLsT3oyCOBWFuCwMF4qkGC2eeqcrgOsZdRLHvQXH1b6vnCyWrW0Vdr
         TbRnFuZc86YmQVQeWvfAiQo8M9Qo7+Pnv5H4iD2FYj+8qSpS8gsGNliYXv+wIvkwDaV3
         rbqg==
X-Gm-Message-State: AOJu0YxdIIZu3GOPNFGtg9RLPTKkvjN77NOlmFay19BwxkdDa7ajcSvn
	ZCUFJ9SFxWJsUE0G71N6i4FkzmH9JRY5XwN9gDBySIL6PLY/1q9vUvWaxYJ7RvYMg6NqvKZXjGr
	lSsx/NAumGFg4H4B5rIu7oYrB7nf0JsMh
X-Gm-Gg: ASbGncvpa/CLbRmHRuzy65wO2KaRn28+WfNGbNXLm/DMtrENvCSbs55KvKb34JDL7fq
	9jI+obbsolLXNXqK2CfXIExTclnJslV/rnNFRQLwWhUeL3I94WjvYfEQxvAABuLn2CM3MmNJ7Bl
	s=
X-Google-Smtp-Source: AGHT+IG3nZ7BZ8rs511zp+LUpVxAL06sCbcpwmCP/TkyQNOXkoYokYpoZN0F8HwdzPwpywvL/i+gEzfkbzmVok5TcHI=
X-Received: by 2002:a05:6808:2dca:b0:3f3:ba4f:d205 with SMTP id
 5614622812f47-3f3cd5d078bmr2650637b6e.16.1739374252703; Wed, 12 Feb 2025
 07:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Wed, 12 Feb 2025 21:00:41 +0530
X-Gm-Features: AWEUYZmw-D6nBk7AIIU3riLILl50_etJdnZmO6-zrSMElKsN8zEpO6gLlJBnlyM
Message-ID: <CAHhAz+hmga0hLQcGtOjxuB+xoOsJ9xvFvXXUWfe9HpFcMRNUpw@mail.gmail.com>
Subject: slimbus: Inquiry on Additional SLIMbus Drivers and User Space Test Utilities
To: linux-sound@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I need to work on the SLIMbus interface on a Linux platform. As part
of my study, I see that in the Linux kernel, the SLIMbus interface is
managed by the drivers/slimbus directory.

I would like to inquire if there are any additional device drivers
required to comprehensively test the SLIMbus interface on a Linux
platform beyond those listed in the drivers/slimbus directory.

Additionally, I am seeking information on existing user space test
utilities that can be used to test the SLIMbus interface on Linux. Any
references or recommendations for such utilities would be greatly
appreciated.

Thank you for your time and assistance. I look forward to your response.

-- 
Thanks,
Sekhar

