Return-Path: <linux-kernel+bounces-381719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C59B034E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9D51C21E92
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8F1632FD;
	Fri, 25 Oct 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DS/LncaL"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3D2064FE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861300; cv=none; b=FMfASvrDZ/ToxFxhMO8AakbWLCEncmkwtAckpfGs9ABPWQ5CXsc1kAfsiCIJfShnnR+7fNIF8zA8S3ikqse9mWQ5fWUc81S6c2ergp/SNmHjt/zIfqiTRYtOl8HvOt7XPI1BeSYMhRnEXFdvxQshpM0Wmi0fKoZL0ypwiweGt+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861300; c=relaxed/simple;
	bh=yiHeZgw/FeP5ohbEYLqHAFPfeJLUA2zOv6polMDZ77A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eV/JLUf6KVCn9EYa1Tbnkn208Do5ak2r6RTC6IcuOPkblE/B0zWkoX3wUYll9DdGcPS3nlamcakWwTFApoQ8xQN/ECqkXcKlFmogzQ/9+Xnr+MSn/avYHWx7bBqcBTcI+pZpUc2gYA7Yl6IKwrMD5GtfRLoXwOpM92qNn2ksZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DS/LncaL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1373257a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729861298; x=1730466098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QG9onz68AihZ0/QQ3v1B+iArWlqGlmXiJf2wzvXf6Xg=;
        b=DS/LncaLYXjhKu+du7HWEc4WTLTr5NXqNE5kQBsXqTHEVe8HilkOQULfuTupG6OctF
         D5xhewqJtSIsmZkbQ89h+yL6vL5mXCxzCKqpXZ6yBlglX7MGace6DbtqnITOga/ToMZq
         bAxerFrFpwYuqqxfUzuhOESHbQVBoyQ6KIQ9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861298; x=1730466098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG9onz68AihZ0/QQ3v1B+iArWlqGlmXiJf2wzvXf6Xg=;
        b=D+8fJO47NnzjtKkLyV6c0SUa1x+UM6ep7phQYF+ypISDw4NJozZXMwwT3OJlKbT1Xz
         KXs2x5LfCmRjkaHpVS/RA2hXjuaEpaIkw3BZRs9OA2cMiXbLNmAHQCQYGos4jgjDU4Fx
         1W7q8hQPVWvsggHFCMvccC9JHQUg3RqEwFnOhlJFi6RzgxB4OnR7xUVbg6Zw6VbwpLk5
         r1tkBjmZdLldyVbctdzA515Eboyq1zH9gAdNDRDh14tlF7COPdIF7qaisAKdFhH7fiHA
         1aYo/UWm0QYWOHDO0c2bhl/GfNe3RFUfZgXlVoTGWLGoyCL20TxCbzyaB/REPkwjrZ9g
         47Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXzAVhTSk2jwVDdwLTtgf7+wDPV93wZSzA8aIDm3ECf6Du/DGHULhdmuLtlBGAPMkgd8jpXDCuTxAZ7rmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkilUfrqM2FQQPJyjqhLw8//pBpgtmUPK2DyzQdV7OUxygkfKU
	lySgcpcIGHZIr9/MvSMICqgAamX5E9bApIJS5C+9NJ0BM97cmBSRYWklHVgKYQ==
X-Google-Smtp-Source: AGHT+IHJnUX93Wrtcww1umjqUe+zoRfp3BcM9ILQsEjYqI3VR2JRbMI+0HgRNN0sieyWVCzDDZYsng==
X-Received: by 2002:a17:90a:e2ca:b0:2dd:6969:2096 with SMTP id 98e67ed59e1d1-2e76b70c545mr9870731a91.38.1729861297790;
        Fri, 25 Oct 2024 06:01:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:bd37:bccf:f3e:a9ef])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e36a044bsm1352978a91.25.2024.10.25.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 06:01:37 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:01:33 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 3/3] media: venus: factor out inst destruction routine
Message-ID: <20241025130133.GQ1279924@google.com>
References: <20241025105104.723764-1-senozhatsky@chromium.org>
 <20241025105104.723764-4-senozhatsky@chromium.org>
 <f5a8c042-53f5-43e2-bf76-82243ec77ee2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a8c042-53f5-43e2-bf76-82243ec77ee2@linaro.org>

On (24/10/25 12:43), Bryan O'Donoghue wrote:
> On 25/10/2024 11:50, Sergey Senozhatsky wrote:
> > -	venc_ctrl_deinit(inst);
> 
> Shouldn't you be dropping venc_ctrl_deinit as you have done with
> vdec_ctrl_deinit ?

Oh, yes, will send out v5 in a bit.

