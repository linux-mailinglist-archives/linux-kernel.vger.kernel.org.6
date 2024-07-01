Return-Path: <linux-kernel+bounces-235551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030AC91D67F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AEE21C21093
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7AFEAD0;
	Mon,  1 Jul 2024 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THUGvWVQ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DA10F1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 03:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719803591; cv=none; b=nyBoefm+/vnmeUz+XTOMzYhVxzJDRcEaiBZY/bn/ZxMfwd2DySjx3Y5B7VkTaBbpNy0nR9inJV6+7VdPneZDxiHgDcwp+0VjWbprT3vJVn5toQ4N/SeRFVB1t3iBjB2AIPgQWvPo9PFzVrLJ5Sbi1GIBZeNsw4qCMJ7PT4Aktfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719803591; c=relaxed/simple;
	bh=qEXRiC/iKjmoDs+rtih2klPX/hIkiN/mQQU7ru3883Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzuk5+08PRTjg6BwPhTflXvCkydyRCPgNMvkwv+gZnJr329SD02zP7AenZoGJEtrNtKKLqQWL+qlwjXlixkho80VK03zM5xguOu271cK3YaYxSlXeVaYuXL8/lMXOFvhcgwgKu0U7tKdaBUEKJC1YfwXE+2OhFcMoYo3udDKoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=THUGvWVQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706b539fcaeso2423534b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 20:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719803590; x=1720408390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov3cXgFG/IkfOMIMvXiqTKHw0svctquc4uSNEAgxs0I=;
        b=THUGvWVQBcKlVUzaUHhtmyDa+TUBrXZaQni1BA8Hda/wlOOK6M2/7z3oD6QJ2YXx8w
         vW4il3mMHEAqmidyHp7B9cwnIQGU5wiq3Fbymfg2JyvslI4v9QcllBjXkjVoQExihSUu
         IdMJsJuICkH5gDPYjX6tGxFLFHmOGeVVmEiSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719803590; x=1720408390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov3cXgFG/IkfOMIMvXiqTKHw0svctquc4uSNEAgxs0I=;
        b=PY8TXVXrAxZXfgl/3Zq5V3a8y5QzrbHcvBt8n5gHeeMf5kbMU4ariy4Yd7m7kJK+bY
         PUSvFld14Xv2Fv+QFVEYHoGtlCWhnymlcY28zLt8qVsj02ZulOjeUDPwJpOL0dWgRxaj
         ruJHaF0xi/TsQj1KzMw4JQgs0QbVYkLJXzXmJXGiqnjmokVcoOg27rJzztiqmhznuJWZ
         g+RfnD7xNqvuTeNVtNxgRMei3UJM0x0B6tkro1WH7Hi+pX4GnuhT77Arwrz/H0f0zX0k
         EPoZelYjLNlpR5Q0wHFdP9TCsmW7ZofAthVQFJTkQvClOuiuIQob81HF+sVbDb9SwZob
         nsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+V6+i0oCIeseXWuiE0FOsAeCH8cOCqlje/j0rH9C81+d8IJvvh0UH680k+0puP7VoZBC/jPAJC+ALky3uysnDuOPnEHYhSPmPzAgn
X-Gm-Message-State: AOJu0Yx8YBPzEwdT61XX6vfDXJd0Oqav+CTTnreOafN/IXuAOjt5cswA
	G/Yyj3x5d0xTRZ9QGM1cFgVg2VXmFJTqUh7dxM/58w6UBzXhHdpR+64AtNeA1Q==
X-Google-Smtp-Source: AGHT+IGIZcx4mQvWzB2ZIAUQ01HWDYiyHyJGsp5rBaeE0II0Q4zTzNYieueJhHRoNnDaufvOyQmVkg==
X-Received: by 2002:a05:6a20:cf84:b0:1be:c41d:b6b7 with SMTP id adf61e73a8af0-1bef624385dmr5811244637.19.1719803589828;
        Sun, 30 Jun 2024 20:13:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:132b:a86a:a9d0:d7fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080256afb5sm5346863b3a.79.2024.06.30.20.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 20:13:09 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:13:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
Message-ID: <20240701031305.GB3232210@google.com>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240628005523.GC15925@google.com>
 <20240628010812.GD15925@google.com>
 <caf4b05d-6adf-4976-9961-fa30d3a9969c@linux.dev>
 <20240701013731.GA3232210@google.com>
 <4f2a5cf1-3132-4bc6-965f-8dc5a8ffc05a@linux.dev>
 <8163966f-d31d-425c-97cb-3d18ab28ac1f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8163966f-d31d-425c-97cb-3d18ab28ac1f@linux.dev>

On (24/07/01 10:49), Chengming Zhou wrote:
> On 2024/7/1 10:20, Chengming Zhou wrote:
> > On 2024/7/1 09:37, Sergey Senozhatsky wrote:
> > > On (24/06/28 11:19), Chengming Zhou wrote:
> > > > Andrew, could you please help to change the subject as Sergey asked?
> > > > Sorry, I should have noted these details in the changelog when I wrote
> > > > this subject.
> > > 
> > > Chengming, can I ask you to resend these patches with a proper commit
> > > message?
> > 
> > Of course, will update and send later.
> 
> I just pulled mm/mm-unstable and ready to update, but find Andrew has
> already helped to change the subject and commit message as below, which
> is great enough! Thanks!

Oh, I see, thanks for checking it.  Thank you Andrew!

