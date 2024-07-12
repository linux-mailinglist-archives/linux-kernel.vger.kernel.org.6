Return-Path: <linux-kernel+bounces-250761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCF492FC68
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4375EB2345E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600E171E68;
	Fri, 12 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caFSjTU1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FD171E52
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794032; cv=none; b=HXmFRqNNMsNSwNasJzfqpCVg0pFufyfTtot6MSobwptterqOUzWkIf+B/v2bFCiRpA1GxQZbTPhZNOWgtUbPZoWvaZ76K8ue6ElZVJa5hEgXXPBTUtgm6/CYhSuhWyAOrGzWOYdcPIu7J4kA4BqBPGomV3X5H4IqTnk7cLHOMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794032; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TYDWFzCQ0ZEeLEWFxAz8ehsl2ru/sKr5WwU6zKGSNohNjwmX2vHWA6K5cZ7+U0RWz6fc95byaZ5nQXBeZF4hzpGJ6QcvIscvqsR+lMsjdqCfpSxgO8YrERo46Y7ZyECZseP6zT/JSvkSFsd6OpWFv6e6fydK91iMoywKcQzs8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caFSjTU1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720794029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=caFSjTU1Ma0ZJ0o3peo5y2DEY0icgW8dVvR6vchEfWUhyCnWsYV8NyovekmvYGRbBCkW4C
	yWo8GhVn0S7i8fqDMukMlNJF+ySGZd19QEl4dfZ065lwPscajC7n90ce65RmssAZNnB6tH
	JWHQ9lA4yjL7A+UXbIgj2kvnZ6mbtI4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-zL8SDbFDPU6rMm2KNQv_rQ-1; Fri, 12 Jul 2024 10:20:28 -0400
X-MC-Unique: zL8SDbFDPU6rMm2KNQv_rQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e035edb802aso429765276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794027; x=1721398827;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=HT4KXD/QnfDpC+R0QnToH6uFSBYpw6CYqsyub9OveIKbYN0g6GRuYkhqPu17csehXM
         ViVyDAeTZ/0G38DL8SSbux+JxRGudE/93VCPnDiGIJiZIm48eoyO7pbGHEVpK0mv8yku
         Du2iXWyCKkepTi5AMfIR485E5QsWTKkyEHk0RFOwYwA+wKRT11DRZEgyyYGrsO3CMnGo
         ETggC59oVl0JVovQUbexEnmypViGOj7mHgm5M0kvcgEmdJ3dkkLkMrswosQOj+jZHI8x
         ZNDkoiHNL6NveFJAA8rkxRQuVOOjdZbpIdJ187YAUpVSGUMiZWj27NjetXI475xfu1jW
         Dw4g==
X-Gm-Message-State: AOJu0YyiDCdB9aWdYdLwFAt386CEpx0KB5AEv061aYqBhnny8I8roxGG
	x4jQO4Xn0hPzRGXH8QAcOl28B51uX59vYd94XGxWlnVK+cTBvD0BT4j+lA4DPnx80KHYxENKVcc
	ep80sf6/LFXJsJtV+AXYHPQs05dRc2psA9Yh+fgL4u1BM4XIWjVAQU9xaV0zJGjm36rm1KOmo52
	Vk005gOuzezqCXNzl8omoXt94Iv6ghIjiqVSafmEUBMtw=
X-Received: by 2002:a25:8392:0:b0:e05:900d:fd2 with SMTP id 3f1490d57ef6-e05900d116amr1138473276.9.1720794026991;
        Fri, 12 Jul 2024 07:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYGv+5WMXkRmrnuYAugAWw8djCKR1A8VtXQWgaZEy6XQY2XnVCWuIwmnwm18M4QSj/5Qka8A==
X-Received: by 2002:a25:8392:0:b0:e05:900d:fd2 with SMTP id 3f1490d57ef6-e05900d116amr1138456276.9.1720794026598;
        Fri, 12 Jul 2024 07:20:26 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.136.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba73d69sm35643196d6.84.2024.07.12.07.20.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 07:20:26 -0700 (PDT)
Message-ID: <36d7816b-801f-473a-ab03-613d00da7a5e@redhat.com>
Date: Fri, 12 Jul 2024 10:20:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
Subject: unsubscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


