Return-Path: <linux-kernel+bounces-439479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D369EAFDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B890F28570D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90D2080E1;
	Tue, 10 Dec 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiCDFFfT"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4423DE9E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830052; cv=none; b=IulYUv3AZ5QwRM+61LhkfTAA80veMK60bAJblwSFcvg2tCRAROxn3f12/8ZKYe1zK1JEOSoPeT7wEzGFmIUm0FuvgEJhdSzM6RPNXbLMINfZw4Axvki8hWRlbW2k+g4A0q32ue8+XyWXIg9y/7BigMP6zsGm/z3lzwqeuK3qrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830052; c=relaxed/simple;
	bh=Np8EqaGYdQhvBb5+vizpkVTufzxd92IGQexHPSjZWv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6yiibS2XPWEIT80QwuirOoGJ2IdM1DiLann0gEnvPWEhBzYr3kdLIaAGwxMzmWEZzfCUDbL61ifFcPqcuQvRKyPOxpF6JsPmTakkSjbM1iqNmvBEG6mZ1GNpUe/7rYQnT8lIwXrX1FLu3oywmVyPcS40XAbvIU1qeqq2r52oc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiCDFFfT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725dc290c00so1884274b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830050; x=1734434850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZDhN/U3QLudftKPFdpchqeEa0iIEKjMILodJMS9YwY=;
        b=fiCDFFfTGZMIHAh8tphd82zV4sQR0GLu++lZRMDBkOFCk7SGaScgGs2V75Z5tscELC
         Tagz1TgesfNUQzyvW45XIJO9xssRdnpY5lUVw5zgQfWSeh8tnnXft5IlmKFhaYB/+pjK
         C78Ejkctp3iZGFaYtZHmU6oDz2u53A7TRjrnkPfeyEbzeycFepdFKo0l39GAiyepLOCN
         RYmpndajHqE3MRcpldXWdERTOjvVtWKN/71S9yGktTZ4pYVzt0vg+a3nS6ry+slV9mPf
         CZitEbDuJtbZ62nhadtBO0eOYdC082Wgac24dcnwkNtmuk9Q7vLIFhL+Qk+abM1clLDp
         4SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830050; x=1734434850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZDhN/U3QLudftKPFdpchqeEa0iIEKjMILodJMS9YwY=;
        b=drSizpyuw7wbe1KsqA/VGdcHJKjDoQICaxL/BoO1QczgsjkuvCffCvlXsu1WSgOy7E
         qb8xJuHRDXnyXsFczviGj3KVn8eqRB46YsKxwrStTk3p3qBG2GIvU5J/26peDDwRx384
         +W06SKaJkqd0KtQ9Jb2fV3UYL7/nZ95dDNL2jY6Z/Nt1H+FllDaT3FWJmBp3FlDpRMup
         EeGL+JyPQV8A/L7nl8e23K9Hw3xMGBU8PhavyHRjv1L1IS4i0lU2qerPkDubwATHABs2
         +iqB/PXj0VCHy9eYSavJESPB0LcDaKjEUSN4fF+BjWAJFVJGKfGwhQmD04B0zf/tHg4E
         0yEg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Fg35wzd2FS4aB66h4l4ZK5b/jMZ1X3iQjZMe6Nd36C3mNjXcjujgLS1gudQUO8ViN+YpvslaXGBvIRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweavIoYNRspBAzlBpjWrIq4uLe3/DbnbTO8oN0sY7ybcQv/kg7
	+YJg34u7jixf1VK3gHdC0vj10pJqCXUcuJNMd8lCwgjT24q/qEbRhl2YNwvByeq/s7GcUuJ9PjZ
	PW+NrsbqT7rZ3d68wbxjo1v1pbso=
X-Gm-Gg: ASbGncusQ3q1oBslfEK9Ho1L/kuutrf7c7Gis8Mc+eo0sylePCY/ZZdwFE7Pzjn9ji5
	scC2BQWIbNuqWLMOrmusEJPDEa6pqfxNowKGKfXUiWZPpEvvxaxhpl5jyee/ZpjMGvw==
X-Google-Smtp-Source: AGHT+IHUk2eWnLr7l6y2KKd1ehZ+JhgLJtLZ/Cfh2fAVdgrOhBou2huS1JRCOcTsW5qScUut0NgTeTko3KMCQvz0WPQ=
X-Received: by 2002:a05:6a21:339e:b0:1e0:c166:18ba with SMTP id
 adf61e73a8af0-1e1b4414b43mr4385767637.12.1733830050307; Tue, 10 Dec 2024
 03:27:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210110935.104919-2-thorsten.blum@linux.dev>
In-Reply-To: <20241210110935.104919-2-thorsten.blum@linux.dev>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 10 Dec 2024 03:27:40 -0800
Message-ID: <CAMo8BfL6v3zoxmd75zseux3aHKcZVj1FnmO98KcwLcPyQUEYQw@mail.gmail.com>
Subject: Re: [PATCH] xtensa/simdisk: Use str_write_read() helper in simdisk_transfer()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Chris Zankel <chris@zankel.net>, Jens Axboe <axboe@kernel.dk>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Himanshu Madhani <himanshu.madhani@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:10=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Remove hard-coded strings by using the str_write_read() helper.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to my xtensa tree.

--=20
Thanks.
-- Max

