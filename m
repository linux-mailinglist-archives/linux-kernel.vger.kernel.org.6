Return-Path: <linux-kernel+bounces-559497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB2A5F480
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC84017CFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D862676CD;
	Thu, 13 Mar 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CQWub/lC"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D026772C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868987; cv=none; b=P0JC1675B8ptltdDAOsONqsv5HiQOUdlzRvbhbq6MTSLIT84JetHHOMiYlam+YmRU3N+3g/hVq3b/9G/6vI9PXto8jfxtg8N9d34UwfAfypr50SImTHaBWppQHWC2+uT+MAcSeul/czPkGTgbGbzaHgKoNb0/oJMv/Hb4c2SxeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868987; c=relaxed/simple;
	bh=1g+NyktzSKK2XkKOy3k13nywcL9Mhib0LiUglpwfgZw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XeX/N4VmoCqtMh8Q0D2+F12RUS1RrpV+jPVpl9PQheQf807/1EqJ0sXfXaR4fsVWU8qQAIsFdxr9XJVOm5aBFcouwm/3g0Ob7SEBrcYCSYWh7OQnUh9/V4nk3ZseRKYY7r+rAMlluEDxDwOYGUn6X+3G+BEzqtGkQOiAivqB5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CQWub/lC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476a57a9379so12235871cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741868982; x=1742473782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zwf41u2oqw87EX3fkunUasMCQRwAQQeTNbOgyP9FzA=;
        b=CQWub/lC8wNKB1Yhwx5NObbw85YNuo9VstX4QF7oFij3y04I4Ugh+rPvM188+fNxux
         mJwhLF/AAjVpSEo+4QeZCQpxSTqlodQNJHsTrmSvAiQe5Usfrp8q/polQIRVqYyCjMBA
         FrL1OxfapIpq9Bbn7F0kXk7Uwab2MmbFLowUAhdl/VPv+rs+2Bm4a5Hg4G+2f8dmJUUC
         IBQvwMVxy/e1w3SV7cOF3wM6ba+iW9/zOVojPMYumqAvpWsbHvYf4Rh0Yu87z8+nl7PQ
         7LHuuchejJduzP5pjXxYV2vdfHRX4WTFaSL6cdYWvGC3RCAqvRHIzcZQV4Jkxi5NnT6W
         4x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868982; x=1742473782;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zwf41u2oqw87EX3fkunUasMCQRwAQQeTNbOgyP9FzA=;
        b=enEYdE02mpvJ+HMBO4u8Etixovo73dYMEJoofSuHiT8+QsRi8RF34ce4gIFvvyx/8y
         mp1bdiQrLbxOwW+l/oK70vPv7Zow7op9y1qK8PUStR63VKsQ6imX5pfp0ir4P2/rLS/O
         7ubyQIfEkASpHSy364MWGcQF+6yfZejOw94uwK5H22nK8jJrQpciLytsG+A6Ay24uiPE
         4hLcgJHW1A6x1lX6Xruyc9KaNihf6lO3y8DcX5oL/qTVP/zuEd8agyJPBpfP2G69Dwyy
         H6ujesELmX1YAnqV4Xj/htXnnp2TWhLjkV2UIJcodZKoQoKjyGms31h1YRWo3igNlJYB
         YYDA==
X-Forwarded-Encrypted: i=1; AJvYcCX8HzmdlmAHNciaIrUQWzFJvRhh+AMSLyceFqkC0BC3ssEZ+1jvDz7UfwV0Jq9hp2x44luGm+zVFVaxHuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6GkW+jkfyAdbQioOPw7OMF0Wu6JqIHuxMi2u+2bRUTuY9T4Z
	DRmLZvj+ghu9B0cXaluXz70EByDExRgABdQAPw0s4cdbka59mn5XUlUnL2AdvA==
X-Gm-Gg: ASbGncuBTFPjJ/QB7KfAUNolUO1xShCIB/n1Q0BiUCW/qbUT5m7EjMvIQB6fO5gFTBV
	2aOsIOJOWiIsYt1jGkXo5O8cqcoc1l+jbqraazxrdBXLDKitTTqomz8/6HqQSzT9OltmM4p0mQ2
	ky6IxbVffZYKhKG+H6+/Tho15iOtkH8mHEnSQrs8qVT+a65JCVjFQiumh9Rd8wVdsdDR+ZWHiK4
	BUILIqhLLbRKFajSj8zwdtVueT7oWJywFD8xaCMlPcz7GMUQvzzZBz5xvUDBNraEQwuVR9FbBpG
	umlA91OuO9V8gCgN08yvDR1gt6PeY1CfaWRa+S3Oqhrl0wqqQpEE5s86Yxhnpy9y/NsBKp3CRnu
	fmUEKj7V4jW4xKqAAUL4=
X-Google-Smtp-Source: AGHT+IFnv2N7W3t0ayHxjjtCyn9mUUoe/Hxh3K5QKhmpW8fJk7aFYPPODamWfDzX3U1KP5rz9GLzbQ==
X-Received: by 2002:ad4:4eed:0:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6e9006752e0mr464948326d6.34.1741868982415;
        Thu, 13 Mar 2025 05:29:42 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24eabesm8979316d6.67.2025.03.13.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:29:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, <eparis@redhat.com>, <linux-security-module@vger.kernel.org>, <audit@vger.kernel.org>
CC: <jmorris@namei.org>, <serge@hallyn.com>, <keescook@chromium.org>, <john.johansen@canonical.com>, <penguin-kernel@i-love.sakura.ne.jp>, <stephen.smalley.work@gmail.com>, <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
Date: Thu, 13 Mar 2025 08:29:36 -0400
Message-ID: <1958f7b4780.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <5ea749e38c39e783741bdd0491a1338d@paul-moore.com>
References: <20250307183701.16970-5-casey@schaufler-ca.com>
 <5ea749e38c39e783741bdd0491a1338d@paul-moore.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v2 4/6] Audit: Add record for multiple task security contexts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit


On March 12, 2025 7:51:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 540894695c4b..79a9bf4a7cdd 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -168,6 +168,7 @@ struct lsm_prop {
>>
>> extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>> extern u32 lsm_active_cnt;
>> +extern u32 lsm_subjctx_cnt;
>
> I'm not loving this.  More below, but I'd really like to hide some of
> this detail inside a LSM API/hook if possible.

Thinking more about this I think we can't go with a LSM_MAX_PROPS, or 
similar determined at build time since we have the ability to toggle LSMs 
at boot.  Need to think on this some more, but the answer is going to have 
to be a variable and not a #define.

The LSM init work I'm doing right now directly impacts this, and I'm in the 
final stages now. Let me see what looks reasonable and I'll get back to you.

--
paul-moore.com
>



