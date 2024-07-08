Return-Path: <linux-kernel+bounces-243822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018F929B18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F028124A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19479C8;
	Mon,  8 Jul 2024 03:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g8HneZJX"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9E184F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720409555; cv=none; b=f6LauvrWad092zO+z5v/VP0rS91Dff+dECn9k9QV/IJYcUZdCtFF/HvkdLDsK2KMRIN0uKTiiHlAPy+zW+sxEhZE61ifVmiQou9L9/Ni2b8y1jjYIzVVQxo6ZL+GacGRAgR+bq1Z5uNRf8Sj2uhqu8OwcmQjEBw+a1G+P5dSzNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720409555; c=relaxed/simple;
	bh=5uPJt6ndXC3JLmQO14ovBQlb/bFzah8Bquk6QpCYuQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQYsdnGRn+/0SBuN2VPgeThceU/FR8DnKMkic1vQNJQxeyw1RInXpplWeekCcYkTJsQ843BEB26TKks+NEQUxSHeLpZx06YrTOATuvNxjkmJk3tVRdB03tF8av3Sl0PPWLKsapVm5bvl3xydJg45wOIrQ/EwVqb/fWlLvxSRRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g8HneZJX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so15578535ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720409553; x=1721014353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXCHivUeTgzK2s7c5iMX6VZA50wGYQ3SoObiW0cz39M=;
        b=g8HneZJXvQZdZ5ZgHsi/2Qds4AmXsVmpQehbE69Z0g/bLLB1QaaDN/3CFDRRxrSRk5
         MbeXOC8Ehw6JnmDZjN3CIhqNE0jek04v0C2r4ZdlrYOsTaWs5SF+yYZqk+z4vTVHrDwA
         O90Yb4o02csvYZoJJ06e4/bq4uqSZsFNuugfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720409553; x=1721014353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXCHivUeTgzK2s7c5iMX6VZA50wGYQ3SoObiW0cz39M=;
        b=lrsndaS+Ao7hJSUcLrKmu3jGo+BaSiSphnwJvJiArYjojbt952+SAwsnFWLqSFuVrB
         Ac2uX7wzaLJUXDwuAvP85uyHFam4Y9Wvta33FwXzTW+MVcKRTGU9DEJnn+a9RwrkB0gJ
         ISEy1xg4Zsf6dDwlhFKxbbi+sWY9kEo2u2HA3lT3zgkCkXBoyneZlPo8rNat0urU5rBj
         pXcc4txx93OY8EX7MG6uQ3fXJMiNSB046M3xFiM/VKXavj8qaGjtv48wpSu19L7qPjLB
         9vegGfHUOj+7LqYvgvM9594r/QH91YfoOb7KGzhHqAITGYgm5O6AV0em+Cz19MTg97II
         nXqw==
X-Forwarded-Encrypted: i=1; AJvYcCW+No8TIookQqd4RPpJDHFk7xLhyHLDKuiL6hUZLR6PGYeYZzsDA4eQORWKRMxTxfrHN702g0/zICpAB/EngJAENSmUPUszgh5QYS5n
X-Gm-Message-State: AOJu0YzVI1XauJ04vpfLUF+4P/vPSh4UlwKuuR2HR1sDkoGj9NLSputF
	fxJTSlUlpBNzJv0mo6IvSc9Ldf5Pq5IpwzYvS7pLxL8n7RI8kFn8McJJtjKOtg==
X-Google-Smtp-Source: AGHT+IEQ9icmnoYZ5EiPLnYtHgy8R0QJ1szKIWGaEQlf865q5Czazs3nuA+XujWtDqFqWgak8oR8kA==
X-Received: by 2002:a17:902:d512:b0:1fb:5c3d:b8ea with SMTP id d9443c01a7336-1fb5c3dc4aamr28446625ad.13.1720409553127;
        Sun, 07 Jul 2024 20:32:33 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:eda0:6e46:c522:d0b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb27bdc357sm75660155ad.177.2024.07.07.20.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 20:32:32 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:32:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/3] zram: Replace bit spinlocks with a spinlock_t.
Message-ID: <20240708033228.GB797471@google.com>
References: <20240620153556.777272-1-bigeasy@linutronix.de>
 <20240620153556.777272-2-bigeasy@linutronix.de>
 <27fb4f62-d656-449c-9f3c-5d0b61a88cca@intel.com>
 <20240704121908.GjH4p40u@linutronix.de>
 <801cac51-1bd3-4f79-8474-251a7a81ca08@intel.com>
 <20240708030330.GA797471@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708030330.GA797471@google.com>

On (24/07/08 12:03), Sergey Senozhatsky wrote:
[..]
> > I meant
> > 
> > 	for (size_t index = 0; index < num_pages; index++)
> > 
> > It's allowed and even recommended for a couple years already.
> 
> I wonder since when?  Do gcc 5.1 and clang 13.0.1 support this?

Since C99.  gcc 5.1/clang 13.0.1 are fine with that.  TIL.

