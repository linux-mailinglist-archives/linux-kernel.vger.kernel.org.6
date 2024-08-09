Return-Path: <linux-kernel+bounces-280913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252294D0D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB53E1F21A50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3DF194C6E;
	Fri,  9 Aug 2024 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sWx5JMoU"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C4194A5A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208863; cv=none; b=c2A7QsN8eh8RopaptvqK6fMR25QZWlkBlr3NvDgI4tzz4ZYgpChJ7v7nzWfjp2azvzUCIuX/uYjL9qbNYtEZQ01DlvoiKNu//Xr8XTvi9r4nT916sgK3h3LMURBAtdX96n/ehMUyHEgWTgIauEYy2xM2flpdgK3IG91HNGJ0Z30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208863; c=relaxed/simple;
	bh=kCFVoFCFuy0U30o31BMxvy7Ab0XDZIvqSHyEB+oQ4CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI/UKF6wKz3cgCJ3UPaZ8S3zbkQDRupU5lQtirqFUlMd/kWqmE4OYZZ+qCtWmnE46uZGZIvXSXmZPIomiX8H6i0QIa3FOj1qaMEoaovmvm6u5PWAi9fekH0im8ST/6eMm/WBN0y1OaV4LBrvphuAhdLBkEjiwJHgrU694VXWHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sWx5JMoU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cdae2bc04dso371323a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723208861; x=1723813661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThAFzPMUuQHD9VLFPcfFOW6T/XOpVMlWLGK4CG7KhUc=;
        b=sWx5JMoUrEXTmPDiP6frb30Bgv47n39B9+cDu2l5M1jIpxCppBDOqzF86XdUU8/yCb
         xl+J53PYMKqQLBuYmSv636vgSXmIBkdSf/o2r8mfWffDNWM+ZK9+K0qX7tUNyT00ZD1Z
         kAVe6M6qDdrGeRu+EjzqQRwvV7fDnZCCqABtz4XgxTftKMuAFicHKAs5kZFb7IR1btB8
         q20WqFSk8ebG2uqhNL9ySAwLg2FO16D2f16EbgtXaATeYja3pDwdFEz+saN47xZsDaGe
         hJChZdUxp0g05UwY7JWMt60Ii6ejXwE1kV4d1GzRYliejubDTDCqHpU+RZI1ioOz/VRu
         JI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723208861; x=1723813661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThAFzPMUuQHD9VLFPcfFOW6T/XOpVMlWLGK4CG7KhUc=;
        b=L/QA2jsi+YrkJvTYwNXDi6UJ5peVzfDPDLPajn0iZozeEf69ljR3C8TpRCpm5b4utG
         t11FuHvimjnE9FyQX7CJVLX4qyi8+ky6r2RNK8i5xkuTJriwy/FUquRes2MaljRk+kfq
         UeA8bo+GQpjpMyvJooqY/Gk0istPRPThJBWeWWDLlBpUgXLhckQGWcuxEKM1z0gfRVXm
         O6N/Br+Js+N1AR6WlxdSrTCSnV9O61msVZfPMN40f4Qc6KYkpGdmgQMxBZyw8MZR7qts
         qGPNBh0GL2t8FglBQdAB8oX5Gf5FWqjXQiefoaBS6kh/t7G1YFpREwhnafdicAVVjATL
         lqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn/YBU7fAdT2bkhil/4M4goRCiqwNkstpCqXkB/SEkiBB9XakjtAV0gaTJ3F6D32SPkYQMRh71TOWh91SGFeSNT9DX75zDgfR5i9Op
X-Gm-Message-State: AOJu0YxHdxVo+Td+ZSHVwljZsZTObp1R5FWKGDOeaiViDh4/UO4rZgSP
	wjIN9yEjSllbQoJRPtZyx9E6Ati+emCg6CQq7/2XIpVycYqOKyDamZq8cUTfMEk=
X-Google-Smtp-Source: AGHT+IG/sFw9tqM0pOt5/pXk9bnpnz3hLNgW6nFzjVujbZLZQ4Vzu051dTL4L9BrTEGMcHavnDGmNw==
X-Received: by 2002:a17:90b:224b:b0:2c8:4623:66cd with SMTP id 98e67ed59e1d1-2d1e7fa2c8bmr901226a91.1.1723208860658;
        Fri, 09 Aug 2024 06:07:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3ab3baesm5285151a91.15.2024.08.09.06.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 06:07:40 -0700 (PDT)
Message-ID: <975158d8-4f26-4b5c-9cc7-eec15d901eb6@kernel.dk>
Date: Fri, 9 Aug 2024 07:07:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240809064222.3527881-1-aliceryhl@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240809064222.3527881-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 12:42 AM, Alice Ryhl wrote:
> Dash has ascii value 45 and underscore has ascii value 95, so to
> correctly sort the includes, the underscore should be last.

This commit message lacks an explanation for why the change is
being done. Yes it states that it brings the headers in ascii
sort order, but WHY?

-- 
Jens Axboe



