Return-Path: <linux-kernel+bounces-442544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A509EDE01
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5FF165211
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D2513633F;
	Thu, 12 Dec 2024 03:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EJkO0igU"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78757CBE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733975122; cv=none; b=qsmi/DW9yCflx6c4zc2Mu/Fb9779U/+kipMFSO0ymsxKJax7u3XGQGLd+WnYvF/2s9g4sc2ICp7ATO5vcLxxD+MmGuetu4dZBdj60o4A3+ajVomBoN2oAf563/cHoD6CrM10CTEDo6PpfSvEXMAXJPaaXm4QuEMkxyX46Lo4Ojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733975122; c=relaxed/simple;
	bh=x+HkIgNwmyPUUkkbZA0RuogAXYb+lJDQwZKdQZLn8Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1GyzA7JVJ/Wrfnc4QzA4tfdwgvz0m28yN2fjOGQxz/MVyaPsyneTYl8rfofRMJEGrSmIbyu6VDdQYnznbtDZdRk32ffm45M8ihDqzpig0422gx3ELmhrr/ibqM8FXhQZ+hVO99+EzRvTJiqI5saKuZCWvMVG1tRhSm7njnVzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EJkO0igU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so1148155a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733975120; x=1734579920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rIgJ32j4LAXyWeUdhqKxIqAs4blXgGJJa6Suew2l3Q=;
        b=EJkO0igUlEhTaMD0fPhzSCqB/kenbk1NNYHgPPfpobgJx/NRcfG/MlON2z42M9Q3C9
         PDJnhYCU66LHk8RTRH5mGVd2YnZbiP47Tk1DyLsL52BL5l0j5QGXy0xUzaPj3WYOc3hj
         Zd97BAN10tFRCY6TI8NJbCyVjzWP/07sbxEZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733975120; x=1734579920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rIgJ32j4LAXyWeUdhqKxIqAs4blXgGJJa6Suew2l3Q=;
        b=tVDpw1avbM7jAXqNMGDtaPXqQ0WAofTy1J5QdjTMFhd5XOogZAxdwGzbNmhoKPMpyN
         rPd3yWwc3een63mZp3AO8MTcUnqhKKecefwOzzvoDto/mtmQdI0tGk3iL0cfDW5YYvac
         VOUeRuZLqQSmzR0tdd20gfOBRVc/g4+WK01m/oAAy9b+A62zQIBr8pVuu624Jc4pj5E1
         TuVgMe6YpTtTybInMVnDQq7PlFGC90k05R1hDog2Z9zN+gNovmMr73nn7eDfJRbLb+D6
         xnPcPZI5G4lvYSzg+mF8tDM+zgYpoMtDlqDhnqLavrSGXA+z/l/Gdhll/HtpVtkNcI3K
         +K3A==
X-Forwarded-Encrypted: i=1; AJvYcCUFq9YX+EuoKS5c7R93fzpBWsun5WHKRd3iFWPD3YpFKhTl0bBSqNsvQliNY7t+Gbb6S/1SYhqdqxAufeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxJK3wUgJNMjdDD7agFkOj+5S4CsHITzxN7ssRFG3EhMYF+xX
	SmvQ0vCjqXhJ7j8Y3E5rbUYAlpmPfPellXQZRLKbZBQJBy90h07lVVGkYuWB8w==
X-Gm-Gg: ASbGncs5u9b/Px976fGW4P0ob5JBPXEIYtX32vsgIxkq0bWAFZicJeSCmUu41jtgklP
	tdsIA6h0RjyZHpMOoHaGRxiRhN/yKBVYZV3E0T2uPojaKC7ziB5/7LnYxzEpfo6AesL2+UqXiY/
	qROvC/z9N0LmNmvEzPKtcbp0+XyIPZFtYR60OIMPLXmxxmSabBI2OMKk8LMNFw8Q8B1NHI/fzfA
	8zQAyhBDO0X6OrZDAlQWOgp9GRVY8B8awUpQlRA4GuGYMp2VNVnui0RzNZ/
X-Google-Smtp-Source: AGHT+IGBbCAvhanJEDHXYcpDDIwWPRqbR1leCzMXpqIPeikgs0NFkxMOlg44rtH+4z9uyf8085HCzQ==
X-Received: by 2002:a17:90b:1b50:b0:2ef:9dbc:38d1 with SMTP id 98e67ed59e1d1-2f13aba994emr2602492a91.5.1733975120284;
        Wed, 11 Dec 2024 19:45:20 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d927c6sm201019a91.8.2024.12.11.19.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 19:45:19 -0800 (PST)
Date: Thu, 12 Dec 2024 12:45:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] zram: factor out ZRAM_HUGE write
Message-ID: <20241212034515.GG2091455@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
 <20241210105420.1888790-6-senozhatsky@chromium.org>
 <20241211100638.GA2228457@google.com>
 <20241211155116.0da80c5143dfd2e133203144@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211155116.0da80c5143dfd2e133203144@linux-foundation.org>

On (24/12/11 15:51), Andrew Morton wrote:
> 
> Probably it's better to include linux-mm on zram patches?

OK, I'll try to.

