Return-Path: <linux-kernel+bounces-279847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C55A94C282
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26EEEB274C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68956646;
	Thu,  8 Aug 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kX51VQsN"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50B18EFC6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134008; cv=none; b=kWtyY/sE1MIw0cVwZaJR5EQwSWFz5o+eS20xD/db1DTIPcAVjpQtDl2yDfOtLC1TKuaRZ0NOfnSClVIOnitDQcXALVBkOXWVvcKYJ/0SgnbM/FyYqzFNlAUHWvgW5umS0nm3SuiPlDv9upKbfOV1fBdp6Jd0ju8vpGzc/QJb5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134008; c=relaxed/simple;
	bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GB0+IdXSYy5M5ujfSExZCohsJootm3+oX2y1Q5DrpIK35efwRnOKlRZKngLemnu+fgsmoE6vPWtcRY86rhcWgb5iGYaBvRa33cWQmd0VWZ4C6p9yoKcCxYOLDQF0xvOKIq78BjUnO/VttokjK5G/I/EHZciibfMmJYIeLQ+2p4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kX51VQsN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f01613acbso2425619e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723134005; x=1723738805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
        b=kX51VQsNCfzuZMarh1CWs9yqqDKqewZdMq+3qTCnsv/VvIlTamFkvXyOm2KXsBGEmj
         P3ZY1xQQqk09Ywb7CQk2VqpVObKwSrjMjhEr6rCIeL0KF+2XBZWoR7xUcDC+QYn+NmmS
         RJpnfef/440k/NroQqHyDl7eVjXgliNBVzYtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134005; x=1723738805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/pVQXy6F0uUkKwDizlXzNmUOGplIeHHGdy6r0tuh/M=;
        b=QxYGHrMIXK0UbiT7DAwHhusWerh0kPXZ6j3yKHdeWKqbSjMH58P7cC0MzfiNHR7agk
         NV/PcpeId8zZ6b7+K3f/9aInr2kuoYkw61ZJaGIaH5EjVm8NZKW7TALIe2ZMSQA4i5DJ
         D5pObGLPNVJ+7TTvY3YtFZ87k9l+wskoOjsLLoNz/Aj5CnQFh/U4I1Esuwl2nlICP+Ur
         aVNdMAnEukM3wuCDyFA1/8IXReLWLhV/vvBnLIUAjm7jG46vdXr4qWZAGBYljTssT/B2
         S73xlxqxCRYeLvHiPxfkFMTLNwOh09OG/MnP75vrxEqzRGlhoet+wvvKg17xzlDUFifP
         tvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm8DWeRX5cHi1HQf0vQVM2yhmCVFGAOYVOovV2/T7AMv5lNa+by/1KEQCmpRu43twlTlMBV/ZueYl3hCOejrwJECHflmPAPa7URD4i
X-Gm-Message-State: AOJu0YysVE2OGjMXmtXpVN/i6YTI0I6d+XYSWIyJcZbQ+HOQrY2PhFUl
	1fVbhVNh9RZQhYJYvxb93io8XYUUAnIiFdeWf3PlJDlG6ffsyZbAYmuWCLu80dAhKwghsYNz2X3
	Kppe1HRBNzZDSgEpNYiRfgomzCYWnGLrHYHM=
X-Google-Smtp-Source: AGHT+IGM+IplmOKg4nDNcKFtgq1VYsAyFc8E27t7Kh5kyZC1RNU1wOd40qJBqKGPW2Fz1pon2C+QpyksgQD83msyZMY=
X-Received: by 2002:a05:6512:1104:b0:52c:72b4:1b24 with SMTP id
 2adb3069b0e04-530e5d52447mr727655e87.12.1723134004820; Thu, 08 Aug 2024
 09:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620161903.3176859-1-takayas@chromium.org> <20240807211731.16758171@gandalf.local.home>
In-Reply-To: <20240807211731.16758171@gandalf.local.home>
From: Takaya Saeki <takayas@chromium.org>
Date: Fri, 9 Aug 2024 01:19:52 +0900
Message-ID: <CAH9xa6cRGK_oscsDNuAm-ZCJmfkfbm1yOTg_6SSzrkojY-CKFQ@mail.gmail.com>
Subject: Re: [PATCH v2] filemap: add trace events for get_pages, map_pages,
 and fault
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Junichi Uekawa <uekawa@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Oh yes. That sounds like a good idea. Let me update the patch with it.

Thanks,
Takaya Saeki

