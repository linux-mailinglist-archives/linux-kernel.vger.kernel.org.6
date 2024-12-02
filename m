Return-Path: <linux-kernel+bounces-428426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F89E0E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A1C28254B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362EE1DF744;
	Mon,  2 Dec 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+sUAtuQ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6C4C85
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176354; cv=none; b=Rqn3tNI+QvTlMC+zfLh4r79bXayQN3QerTYDuAhl90NRYnFC2de+inkSrvudioXVp1LbyjerUXVObppB3lejjXvaPbfbDSioL5bd+E0CH2Nlbil6DJK1AQhQK1cMLFDwTfO5+p2s6+YrVbMosoDoB8KTvQyxDLllMTKKExLSzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176354; c=relaxed/simple;
	bh=IaZNJdNiqTC9Fp2cbi3B0hJ+CyjA6utopNG5kl7MHhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVUpGRFqd730x5BEFQDp0adctNIgJy69aI2cfnkAmYYL1w48ioXteChfv0CmKhpydzPKmTydmjbWik1rNPLl1XUFxb2oKQ5PWjEPznTWgd53FM4+4A+4YeztbXWcyc6FtPxsCilxGr20NXKnZTOb8zMD6FzGL3h5JElWAqRkkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+sUAtuQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7252f48acf2so3380323b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733176352; x=1733781152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IaZNJdNiqTC9Fp2cbi3B0hJ+CyjA6utopNG5kl7MHhM=;
        b=r+sUAtuQYV5zN+QqxjespOM8DDqvz+hT75qiH7Y7Mmuo8RREbC1+0CbykzBfVXoRGE
         aCAU4rKYw0ycfM0EOpYQ774PHpGdsiw4/LTXoGWGff6DcQY3Z78e7VLphlaGEGtL9kMF
         rdg7oo9R1IvPjIPW9lKIOWbqROBIVuDYvJngLsCuGj7mHp1RqKayHgnnDgC4jpniq1bw
         HpYwDYHB5+XK3RGqvBfdEjlJJLOCVVmo1ZqYYpZ+Yh59ATEBdaVa+AV9tVUbcVVQ0UbQ
         6nzjp7QqiavlfGiwy6JoIIljyXCJff0rY6/yv/R2g6wbuQPCcpMyfRW4IQ2AFk8f74gu
         ENtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176352; x=1733781152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaZNJdNiqTC9Fp2cbi3B0hJ+CyjA6utopNG5kl7MHhM=;
        b=tR3TiVwpovxo91GB6jLf07AISZX8mQsshAt8p1K62oP6VlSCbYV1yKK610HV43DIIx
         +H2XTNOtONJhaVUGsCsVKjhvDaUnl46OZqkuXo94zG9HzyTlgOLhNhI/64Ig7e7lSWv3
         J9ypU/+jUXNj5eZ/DtjOIhnT2tUF1iyakIffks4ZZkBuCunH3KpRzdacF778JQGUl9LM
         bNgKw2Q4f9ue/89941E96PdqhM+bwg/s981m3sIrW6TDPFLMKM87CsorSBRcVBZVre2d
         QBpjwdMSzAIwRajuTU2fvt6tmBvqWwZX2egdNQwPMkKXNE11Fu7WfhGHtx3lAG6RTEcE
         F65Q==
X-Forwarded-Encrypted: i=1; AJvYcCXplSLREmzpWTt5EBuV8PD5d3rW1lmG1rdTcYbvP9Nc93l+ZVn4lySUbXEhQH7pg4kKly3fc7xVL4hjIxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7LZwXBOSZgmK/Ub6Rq76CqeVsqStVqtOjEArhOBppGE2vdhmK
	G+yxV8ROJt/z9L93wLRig8rR0gbihU1/TYrFbPsZe9hzWcyQXwd1tOiBWY4MZG7ILAnLnxPPB9m
	3+4WR7ckSKWS+HtbPlPEW5TEn+xa9BO8g+Ihd
X-Gm-Gg: ASbGncv+i4IwRQNJRzxa3Zyl/4oHuIs2r4p0ntgkNCCDwrw6aiV1+K6awhOp8BV5VsD
	/tKAspX1yPT5JhaNmF0+w2O7Fgqf4r2BbLX+fasOFR7NrA3aOLqNBAoPeGtgErw==
X-Google-Smtp-Source: AGHT+IEWdhwsi+m1PH3AOfYF20b8Lk0d26QGk7Pos7WAG90X7d6QuROnvVXcRr2YlbgnPFHO7qose19PfbdhIFKIzT8=
X-Received: by 2002:a05:6a00:9289:b0:71e:44f6:6900 with SMTP id
 d2e1a72fcca58-72530133295mr31797470b3a.16.1733176352355; Mon, 02 Dec 2024
 13:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 2 Dec 2024 13:52:20 -0800
Message-ID: <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Max Kellermann <max.kellermann@ionos.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Looks good,

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

