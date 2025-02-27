Return-Path: <linux-kernel+bounces-535692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D594AA47617
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26F8188EB01
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D222165F1;
	Thu, 27 Feb 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hyo8AY5e"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5D4A1A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639268; cv=none; b=taJM1tuYFxqAZqp2YPqyl5wtWq9nWAGCajhTH9zI+yAGSoJAGqKlMiN3nunNvLpvrqYd/11agHgw6wpj4f3sNXnj47ijFphpOyuI8nKirrPc57cQg8zcMo+6P1AHdmZGLEDltDFLyIDt2tGBUNfmG+eVw3Hi0ZIcxBdpIGSpMYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639268; c=relaxed/simple;
	bh=lzORzd0bbuVVhlmBUyJmEfYlw5eqNKYZeCEP+JpbZTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBAQ8nM6EVhtDMK9fmXCt+OFgR9fCdQ7q87JKO1JxYsztTv48QDlVv+ZjFh6kAX+saYCUfYt7z5WRr3PwNpf9VWfAxpWA+y4Lyw9W+IgI4oSC34oc8obTJSoukRGoDrjAQEdbR1ersOIeviUAOfGuX4hF1tfscnC5LqaUhGtod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hyo8AY5e; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2211cd4463cso9598245ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740639266; x=1741244066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lH2C/n46Yht8kzUV4sr5Zn74fCCKRKj2j+yhvxYr5To=;
        b=hyo8AY5eb9VaJY6jH9Z0Awsh1Iehc+5t2noYTRUtWjSTIc9he5k2e/ir5x6GFZ5cLv
         uQ+wTWLiSwtXP/UbnHxN1UexVU2F8MGn7bTUbgjQkdWtGLgZLgnKACH8StyA42vUZlne
         wcji2R1Ta41FdgwRdqvKrxysoD8v95WmfCyAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639266; x=1741244066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH2C/n46Yht8kzUV4sr5Zn74fCCKRKj2j+yhvxYr5To=;
        b=Zikvh6tGgjNaKjiSuvkgrkYmMM2F4wC4o5H8YZ9wOLQRU57SeF4LMq+0thEFwicQJv
         WuOV1UaCa8yzBTXyRoisNTZmTyZ5dCqUAk4VamE31lPdxX2EVWUlFr3zRK5ctS5wAgVA
         cgF3iVE7IQtIhPqRsB10/1Pa0AZlLhUE6qPOBjLY6WoiaCiTHB6hbCYK+Dw+tWlsvz49
         TKoe4y6cxgvB4wjlhnjZKq+yoAyyyE7kipFGFOWMczPZUOsUleCO+kWgJyfMiryYqguY
         90Qa0gkqwJiQc10ff6VnkRjYaC/JloHvxYfgcDqSmU2MC2MRp+jWIZR7fFJQo8VyOyk5
         PF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTuExfYS+UVMXw/LosRY3ffQNHJQQyonYEPx6T5h+8RYq/p+cNT2XfK6JhljqxJMUmSXu91mzXqMWnCvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcjjpKmYR6KgqikNjzZ1umyEFqLVcy066q9y5D/nFoV+C/NW9
	5NCsfrddqAXZcqTGZ+fuBss28cI0S73ATlo+bbOWOHLd0aY/usHFE8P7i6nlxA==
X-Gm-Gg: ASbGncuwOQeDXAFxJQyvg1cPbGo8pQvgLRb0semLLS0mlFUuJZ7pWk16b/A0Z7PCzka
	zmwNstdKGzjUdhCYhAsJhlYGVJzLXCaZw+eleYZJ/TEVCE/5LcvyZSKnq4uypLWuD9K4ooYR6A1
	cniz9dM4Jhij5xouAgOxaJ8FtGHJty43tukAeCd1kUYn2JKv11wwmYr5WbVlqPTnPzyJlpTdBse
	5p9L+ihu02e4d+mcpuGDrZy/obi40AODMLXVwIiX7XvOXiYdOgTF8cy10BYDe3/j+HvLHajhqSA
	I9zsqkG/fhFjot6BD2GxtWf0P2JhPA==
X-Google-Smtp-Source: AGHT+IGSM3FsMOChRapiomjr2yB8jTVLSryznMtKWSN4x+YoPzsnwyLngheGCEYZdw2ccKAMG5s3yg==
X-Received: by 2002:a17:902:dad0:b0:220:fe51:1aab with SMTP id d9443c01a7336-22307e675camr183025785ad.38.1740639265908;
        Wed, 26 Feb 2025 22:54:25 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050fdafsm7123465ad.214.2025.02.26.22.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:54:25 -0800 (PST)
Date: Thu, 27 Feb 2025 15:54:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 14/19] zsmalloc: introduce new object mapping API
Message-ID: <4zyr3n2h275zrzgseyvhani2m3avsonobqpg7xzumsnm5rzum2@b7c2xenjkidz>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
 <20250227043618.88380-15-senozhatsky@chromium.org>
 <Z7_8koiBRTfQ81bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7_8koiBRTfQ81bb@google.com>

On (25/02/27 05:48), Yosry Ahmed wrote:
> > The old API will stay around until the remaining users switch
> > to the new one.  After that we'll also remove zsmalloc per-CPU
> > buffer and CPU hotplug handling.
> > 
> > The split of map(RO) and map(WO) into read_{begin/end}/write is
> > suggested by Yosry Ahmed.
> > 
> > Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> I see my Reviewed-by was removed at some point. Did something change in
> this patch (do I need to review it again) or was it just lost?

No, nothing has changed.  I am actually not sure why it's not there
anymore... Sorry.

