Return-Path: <linux-kernel+bounces-197903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F98D708B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075F5B21A89
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB915253D;
	Sat,  1 Jun 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsLAK5cR"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C31CD3D;
	Sat,  1 Jun 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254159; cv=none; b=BV1VQhyZEeMTbCzh+6QWywh+mc95eRRHtOL/VWXuI/AEzg93aKKhcpa40+25spoPp/sT7IVdE/M3ZntJ2H5FJ8W/Odw1FUb4QpqPwzyXS/xxaowvT9hHqZdQDIemBq5D5chibLa+gCmEU9w6kS1Lxkg7Q3tuOXncQ2Lz+U4/R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254159; c=relaxed/simple;
	bh=qTjU/TippBIBluChZCNGHhy1DPcvvexKMAWCo0qp0Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyCi0z4zPm3UE0IyZdSjfVGP1W7ghpuKNTDyGsUqDYwECgiqvWEchnPntICt/I1TMpmRkoIGuLTsbpFi9w7KO68OPhESHjMLwcch08Oz8tNnYyPLck0qwh7m+mqG0ZA0XGFbkVw+PJ5fhvTpyzWkK4/h4M0kYGJXI2sK2l48iag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsLAK5cR; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24ca03ad307so1603235fac.3;
        Sat, 01 Jun 2024 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717254157; x=1717858957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeHtycv1NrGcuFGlOJxaUeyL3FoJw5Lrqo8poVlugY0=;
        b=TsLAK5cRIiie2xATT8uMB1lRd0Voi5mbYWpQWF7p13/xudRA/o+LY60H/TKR826yPU
         7HO9SQBKAMq2r2wcB98BYdWgyOD5/d7SfjL7EdNj4n6UQf7IqXgo5DVRVx+L0Vo93O7F
         wC7nD4RVqZAfyZ4bUXBua3wMRuVBUCfhSiscdaB30X7khclJBG/sU8+g8wkVjquTVE2D
         yXaX9FTY/3Ie4jVo+0j0sPXMWTvomSeOzs/Dl16WowJO8tC0DGkOpYWXHGN0qfpb2LUr
         OUSzcveX2CdM5l1cAaURPG8VYt0qBy2LO7/U1/meHqjVYjSRI8q3Poyy32GttQ96PfQL
         F84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254157; x=1717858957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeHtycv1NrGcuFGlOJxaUeyL3FoJw5Lrqo8poVlugY0=;
        b=tI6QA/kTeb4sFZT+FdXxUi7xate5eyBurbsz+dXz3A1kQDkMki6oEe9FZnQwLnf7FC
         ZVZ3wpe6Y6EERHl8QZaHQthgsEeMfUlyuvKXxV9VWFs6WyQ7DpIpsbCb9KRtooOfTz7O
         Eei+JVI0S/kEuzt+n2BZWy6sByrwDHNWJiWv7PhfrOq2udae1zBwzbnZFyKTLpwGpYtP
         QS8pWsUz56lcW/IBrdHWUpoTk9IVYozyC+E6JQ5hNbtdLlYaEW2qIxkgf999Idikj7QV
         kkx+fbtQq3n77iDsDEtD441v4KcZ9egafEI+WjIODZ+psjN5hUrk/wBN7fDt8vSFJXjn
         hREg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Xu3EszxaDkHyCOMUj9o7umUmXyFGZVUZtJb2azCbtWg4icwKax9Zwo0C9840XWCZdIaF9i1nREBP59jNu1C1cN8s/oA4hIg7RyLU
X-Gm-Message-State: AOJu0YydiV3N+VuqahUZ3uirHZNcwuf+RDdsvK5aupIpF4mIqzMs3dvJ
	hL624+OaUS6ta+nF0qFccAC4BNpVRb1dBbkjRZA7It34qB1roC+e
X-Google-Smtp-Source: AGHT+IFhAGP0l4w4JyaYSs0w1MZm2Y1A2crbOP/IlrChZZX6KMlnn/wb1umAaC6scLTIFeKlTLkKqA==
X-Received: by 2002:a05:6870:b486:b0:250:1322:34c0 with SMTP id 586e51a60fabf-2508b9b843bmr5819163fac.10.1717254156568;
        Sat, 01 Jun 2024 08:02:36 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25085000afasm1216495fac.23.2024.06.01.08.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 08:02:36 -0700 (PDT)
Message-ID: <a97648b5-bfab-4ac7-ba8e-bb6d30b558bf@gmail.com>
Date: Sat, 1 Jun 2024 10:02:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
To: Jonathan Corbet <corbet@lwn.net>, bilbao@vt.edu
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fdf68be7-875a-421d-8bc3-034a21990679@gmail.com>
 <87ikyvccwc.fsf@meer.lwn.net>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <87ikyvccwc.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/30/24 14:34, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:
>
>> Extend the Index of Further Kernel Documentation by adding entries for the
>> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
>> on the second edition of Billimoria's kernel programming book. Also,
>> perform some refactoring: format the text to 75 characters per line and
>> sort per-section content in chronological order of publication.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>> ---
>>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>>  1 file changed, 44 insertions(+), 24 deletions(-)
> So I was going to apply this but ... it doesn't apply.  It looks like
> some sort of weird whitespace damage?


Apologies for the inconvenience. I found the issue so this should not
happen in future patches. Replying with the fixed patch now.


>
> jon


Thanks,
Carlos


