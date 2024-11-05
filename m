Return-Path: <linux-kernel+bounces-396510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D039BCE16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2DC1F222D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3971D6DB1;
	Tue,  5 Nov 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VTtEbvlT"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FC1D5143
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813930; cv=none; b=WkW6+cl1+7+RvItioE1eY8uuWAomHwZaKH+3nqOTKALtlQJCxzWgh5ZkbOg4ykOfNa1FxhPb1fyzCIe0sx7E7TGzA5PTL8SbH4AvsNu+yjKIiQTSxbGp4OsRStdBM51y2Mpl6F1BYduCvT/QAtGcDKaYslJWDoH8r3pD5nKCS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813930; c=relaxed/simple;
	bh=yh1p+AhkWM4xFMAtZ7oOEO9mnv3l6TsekjZBUbWKZHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byEh7xhDleqMHJcdJ7ACILqTlcgJVLdqQI5J1y3nE+UIfYeAnXnTBKBh6Qd9tSKH8ynDd+rXmZ+b/1nBjvzJ1HCB7gd8wQzbWEOHg4JPX/sfS1PPA/Ubed65cMI9y+WIUmy6Do9UsaHyfnRVKxPcA9GS7X3/v/TTWnM2PcKB7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VTtEbvlT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2891055c448so2125989fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730813928; x=1731418728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cV5o3WhWVOPFdJQoEMG+jv0FEl4oyGKv0FBzhxP78ik=;
        b=VTtEbvlT2XLlxplgw9McgVJ4jcXtTiL8IOv+w+evNmSibXY/ZgvlRWiaMpM7Mpcs1h
         c4kPlGICap9KfQ5bG5DRiqVFCPz0/5thJlae8DoYE4/hHB35JT8YBRlmK2AORtwudmeb
         Y9gc967QWu6v/h4zCuk+oIDbvHcX2F6OHhlKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730813928; x=1731418728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV5o3WhWVOPFdJQoEMG+jv0FEl4oyGKv0FBzhxP78ik=;
        b=bmM55x07i+73THbEG0f6+rS/77TpgVDnsB99c04XRVF67Av6nHfyFB/e9GiBCzWVRq
         bTm0IyskPuhYa0e66hFH45IiEZ8a8epQgzaKwWICW+UNE16a6JgOGs/tIZAgAzrz6WAB
         miDOEdaXPir8GwgusOmIBjQd0aXFUdUJCP5+nmfqBrrQ3Pn8QA2TFyfsVJIokztbw2zS
         FlrtS8WMIoRxitgQezVP0ZO1+Ym0z2t5XXJxRp/NOCiFBCZuJwpIHbPj7qlYwdeXlCpk
         LU9lLalCGmt0fovi1oIdmqw/yU4MsLooot9fHv7a/0ZwC6FkbxaSQ5lTqQVMGV6AI5bs
         ePzA==
X-Forwarded-Encrypted: i=1; AJvYcCWvBOoDyb/zWS8DXuDIDqe3KDLUI9wuv8htASWejfwuJq2f4RTrPYwKxo+Fl5s2ABAx0+urvIkNnbmj9rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMdvQHtJ18Q60YNA5hE2Plk0HIbbzJJItU42txs+qiRs1LoD9
	f3laY51iZzm+lHxjbL5LOv4MSAYXf8KVBgdqo5u11B0u4mWQZS0azV0PmwxM1Q==
X-Google-Smtp-Source: AGHT+IGsgQ/6CuL0YqnGrmyzIOA69jiw5u+Wid5BjBzfkM3Z31ADKK+7Jq4rj6syR0JyqOptl5hmlQ==
X-Received: by 2002:a05:6870:8dcf:b0:277:a43a:dac2 with SMTP id 586e51a60fabf-2949ed9b4abmr13867576fac.17.1730813927824;
        Tue, 05 Nov 2024 05:38:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2c73:a2d8:c3cb:500c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f8ee9sm9044983a12.72.2024.11.05.05.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:38:47 -0800 (PST)
Date: Tue, 5 Nov 2024 22:38:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 0/3] media: venus: close() fixes
Message-ID: <20241105133843.GA13546@google.com>
References: <20241025165656.778282-1-senozhatsky@chromium.org>
 <37a906eb-4cd1-4034-9bf6-2f9f4560b9e3@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a906eb-4cd1-4034-9bf6-2f9f4560b9e3@suse.de>

Hi Stanimir,

On (24/11/05 14:04), Stanimir Varbanov wrote:
> On 10/25/24 19:56, Sergey Senozhatsky wrote:
> > A couple of fixes for venus driver close() handling
> > (both enc and dec).
> > 
> > v5->v6:
> > -- added kfree() backtrace to 0002
> > 
> > Sergey Senozhatsky (3):
> >   media: venus: fix enc/dec destruction order
> >   media: venus: sync with threaded IRQ during inst destruction
> >   media: venus: factor out inst destruction routine
> 
> Could you please combine 1/3 and 2/3 commit bodies into 3/3 body and
> resend the new 3/3 only. I do not see a reason to apply 1/3 and 2/3.

So the reason being is that 1/3 fixes a race condition (stale data
in ->fh) and a lockdep splat (wrong destruction order).  2/3 fixes a
completely different race (IRQ vs close) condition and UAF.  And 3/3
is just a refactoring that doesn't fix anything.  Are you sure you
want to squash all 3 of them?  Because they look slightly independent
to me.

> Also, on what platform this was tested?

I ran CTS on one of the strongbad devices.

