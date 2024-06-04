Return-Path: <linux-kernel+bounces-200971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327198FB7DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA04B2874A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5021448CB;
	Tue,  4 Jun 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YxOtYfy9"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A036BE4A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515620; cv=none; b=KiyGI6koQF+jX2r5Vz7YdmTfv+KS06++87WcCHKHjXOXRE4xbhxKe6smury7qW8M9q7qfLO4haae8PM2XYJlCBsNnikIzFdpWqMePM3eq4VY27UoVhtmimcja0lUFjxFSARXeJyZzBc41xjYSeM/Y+WmUazoRM5AiJXwL91d9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515620; c=relaxed/simple;
	bh=lr2PSSnQhT89h9G86Va6lFxZmi+30HqkLtMjm5chdfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmF1zHpZgAxbU4yfhmNWejOOO2c8LOjw1muPWqBDtdsSIzhRa17timdFCFgjXqwyGLzgCahwlgpi9HABt2vOmWni3yRoQl4mDDV8DXaxVEFHC6uil0fimm5lC3YOSPgg2M5F/1XFRAaJkmFCnfQpoa2glR0KRQq4duHCKPYnJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YxOtYfy9; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36da9b73a54so2067425ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717515618; x=1718120418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fB5FPvvwrr4NT7PeRI8WmiMb5Wg2ojKwwSpmWCxqT8=;
        b=YxOtYfy9UzI3WJ0Hohjj4eAI03mEwVVQc+qYObMdzNibes08pchVrCJoUxGs5jwFmv
         2yqH3tPI9oSQ4X9YINd5cvCr3Cg+0d+Loz/lICaQsH0HhgxLH+zB76xFHEJeJbVDpjKt
         XOwIsPh6KKK1OSLIWggIY5KQfFfIskx3sn8Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515618; x=1718120418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fB5FPvvwrr4NT7PeRI8WmiMb5Wg2ojKwwSpmWCxqT8=;
        b=cyuQcPA2LOf5RX9N+JvK8SJtvuXpmdgMS1jCDzbx5CI3/AOF5a1ChaAPVlDqoKwbJ4
         u7JGXB9QvBIMnJSmjsFlgSmkV5R1e0/JE8BtCRtwILGNbJyy2mLaa6U70n5cxUBzoEuj
         hTavvIoxp9KtaR+PkgpqEG3U3Iwjjgc99HdKgr2UiBOYv7CzV+RDWs/jWrn17uy52TGE
         kuXB1/+tDMWlOLgS7wCcUnrzPGc07FcMaMSuhsFi4g8bnJeZZos1qT66Hmg7WBSq043m
         6fXaelMRQd7IFAEBWX0CO0sDTG++H2z72zqoBgXwNl6aW624yiRbiIWQEuSi5PhScHgy
         e9mg==
X-Forwarded-Encrypted: i=1; AJvYcCVpKuFiZ5oWs+cgya8xphAaPFkNyiPlJPaM/yJX8S1q9spDQ6abE0Nzx8Ptdg91+PT89dENgIG8BYwj/TFtvxp9QQB/qD6PSC/fa0HF
X-Gm-Message-State: AOJu0Yysj3WbM6hAv1HZqDZYbBVtiaf6JYK1TvMJcWrOUwKfINwckj5H
	0VECD1/hafCBe8pTb+iAYQzUtbyc7r5rGCuhSxdCivT5riGdnMRUZDsUiFDMBZQ=
X-Google-Smtp-Source: AGHT+IEsuA1KzjXAGIUmi/gwaj8vFDQCmvfkYKihQMeOVh00VlDkzSx0bCO8bpePXWgcQcxuRdyLIQ==
X-Received: by 2002:a05:6602:2c83:b0:7e1:8829:51f6 with SMTP id ca18e2360f4ac-7eb29fe8544mr339203939f.1.1717515617743;
        Tue, 04 Jun 2024 08:40:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b5c41fe2f1sm1219570173.83.2024.06.04.08.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 08:40:17 -0700 (PDT)
Message-ID: <931b7b17-9abe-4e3f-8df1-76c38367b372@linuxfoundation.org>
Date: Tue, 4 Jun 2024 09:40:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.10-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 09:37, Shuah Khan wrote:
> Hi Linus,
> 
> Please pull this urgent kselftest fixes update for Linux 6.10-rc3.

Sorry for the copy and paste "urgent" - this is a normal fixes PR.

thanks,
-- Shuah

