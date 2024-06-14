Return-Path: <linux-kernel+bounces-214270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54931908204
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E4E281A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A219B1836FE;
	Fri, 14 Jun 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="WHL3rQII"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A013201
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333267; cv=none; b=lCADiVV6HF1QJ1/H+T9/VYaI4Mh9Acrk0C/O7CNkrmUIteOC9Q4Z1XLPCprwEoNPminjpykLEraysdOdJfMXADkYInHiUt31DDntb4znxpuXe3kgCEvfFglhPMvOZYso5k8hxKke8SYJw45L5lVCCEazAUX/3JBsEOLfTCdGtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333267; c=relaxed/simple;
	bh=uVZB5kz+WSij71fy+S9z+Z5qsj0MjMMhk1EVCUlnwA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5U3KnkMUI5Z4R/ahEQa4AAFaIK3EUJ03iG11tU5syR/1q/l9lG1HjbWr9T2CCiuu8d1RHldmacRicZzPaAglc0LqeOKnOmryle2kfx79j/2ay5JHcZo/Je7PXwJTfHoshifoHKQ28DKqPZlm1qsM14D9kd7BquKvR4sEQrAaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=WHL3rQII; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70413de08c7so1279666b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1718333265; x=1718938065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxSLIdsJYn8L13kFMpqrr8gKJyf66QofWKoZIgr+wgY=;
        b=WHL3rQII6D97Rc8IB0Tkg/sf9KH0EY5SsngNoCk4w6D4EPurhhqDTzRJL3MMMFXzcR
         JVgZUWVPNZCSo7GbWWCY5q+AvkSyb7/uwKjOLoK4ma/mS4XMiHUWgzkxOx1hOnlJIf89
         p/n56OaoQyNjBLth8QBBzbbEJR4z2Ez0zgSmgZfDra3QLaC+z+az79/hx5uYV67qZPEV
         QUomIWwB3NOeEQE5N67I/AA7IAdq19wjxt9/u/NV3BdM1rqmPoEglwZoa7hT99rPoHoy
         snqCUezjM9YfsATEtfFIJxCSXlInUs4TK7UTqdDPyM77enkIr/D8nPeOj9isCq5R4FOy
         45Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718333265; x=1718938065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxSLIdsJYn8L13kFMpqrr8gKJyf66QofWKoZIgr+wgY=;
        b=N1mrzpCah7JzNCjc5pvG0MAzus1RvvwoqXLoGOf/MPPVaPRxA4P5UMUm5c1XHEB+2v
         IoaoHYAXVjLFrt9kouCjGA8QjcU2wlDwctS6XYVymc4zvEtaHYQLIaXYq2Nc3B4LTkQN
         lDUOtZrZ196RzDfTQHtWCexEq3Okteu0rAT6Dn4Ui3afBFzPr3uWkIXcAVYijRBWR1SW
         AxO1ibyhyF1cpmEIHUF0y3wgwa4zsGG/HHiRs7Er+LFyy3PzIwTDu6LJDSL7UDim7QEb
         8iVA/9UBn2Sef/i7Ipude7ddTXmEHKJcxb9DCmtFBw49lYJoOuyB8rEw8a4uaTAOF0KT
         /N8g==
X-Forwarded-Encrypted: i=1; AJvYcCVJJjHA2UV0Fm2/X8lR9ZYGaRuQp8DUtJru7u7qNRzaDruHPVTEa6RrgzvHd++1adEz8bg68nNEN0wvp0eOu1vB5DvWf8Y9DQ+QUZCP
X-Gm-Message-State: AOJu0YzTmObIvHdofkXbzrgv2VgOmg/K8Zh+bUIfqXha+RTDUf4vuoa7
	NT19dTRxPXlXemFGYf7FkEZcWBSCcj9ljxAfILeAWYLrG6qHTVozEIEtAVYyxw==
X-Google-Smtp-Source: AGHT+IE683ajsRBcowE+5k6F8E0Aj8v+p6LFMNxEoJG3EgV/0IHdxu404aCfy3pjHiZMUdB2OS4dpg==
X-Received: by 2002:a05:6a20:8405:b0:1b2:b220:2db6 with SMTP id adf61e73a8af0-1bae7e22a62mr1754652637.6.1718333264722;
        Thu, 13 Jun 2024 19:47:44 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:3a42:c007:5df5:153a? ([2804:14d:5c5e:44fb:3a42:c007:5df5:153a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45f7840sm2567380a91.32.2024.06.13.19.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 19:47:44 -0700 (PDT)
Message-ID: <de8e2709-8d7f-4e51-a4a4-35bad72ba136@mojatatu.com>
Date: Thu, 13 Jun 2024 23:47:38 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net/sched] Question: Locks for clearing ERR_PTR() value from
 idrinfo->action_idr ?
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Network Development
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2024 21:58, Tetsuo Handa wrote:
> 
> Is there a possibility that tcf_idr_check_alloc() is called without holding
> rtnl_mutex?

There is, but not in the code path of this reproducer.

> If yes, adding a sleep before "goto again;" would help. But if no,
> is this a sign that some path forgot to call tcf_idr_{cleanup,insert_many}() ?

The reproducer is sending a new action message with 2 actions.
Actions are committed to the idr after processing in order to make them 
visible together and after any errors are caught.

The bug happens when the actions in the message refer to the same index. 
Since the first processing succeeds, adding -EBUSY to the index, the 
second processing, which references the same index, will loop forever.

After the change to rely on RCU for this check, instead of the idr lock, 
the hangs became more noticeable to syzbot since now it's hanging a 
system-wide lock.

