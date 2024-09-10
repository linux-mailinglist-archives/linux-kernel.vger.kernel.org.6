Return-Path: <linux-kernel+bounces-322788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4D0972DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440EB1F264FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E155D18B46C;
	Tue, 10 Sep 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NSEJCBRi"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA937188CC1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961065; cv=none; b=VAd+UiGjXvgXWhr95U0OHsrhTfH/aBIjR3ICBg0wKTiruHVm8iJV9u23LnY5jZW9h4ULw6FXsuJeJwinU0fNjBm54TyRDwaBK81hisuSA91XUwbzTqUA+pCR0/QsSQViCI76thU0gB5etorItHPEK4xaplyr3pqOFs5vnDpP59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961065; c=relaxed/simple;
	bh=ll6uk2BwnwVbIriytb9lmyB6CmOKQUi7lDm2570Qklk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv9eIoiF2ejddJ6mRV48gTDL+v350x69iVvJaQym8cGsMXGxsVKhKynaixCwlFXyjyKT+BX4tT5w2DcWsvw9LREH8EQp1jLX8Y15wDeGqEsOshyvRrZHLufA74HwZigkVWjFeYwqppZDIuSliuo3rchdELOtkeuBOVZTlDr8Gug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NSEJCBRi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c1324be8easo4320598a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725961063; x=1726565863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ll6uk2BwnwVbIriytb9lmyB6CmOKQUi7lDm2570Qklk=;
        b=NSEJCBRijN634pTNxHQiy6JM2x3OPNA0AeHxWeAvJsf53E6f8YbPfnBzRtnnhTxoHt
         S4UbCZFbpQ++lBB1w1FRSLmKfX+EUKou3lgcW+kZProsbeYv901cso17Db4FSdB19dS6
         L2V5gRrjEVhUWTej4a/1Q+TTTo7cCOpz5P8Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961063; x=1726565863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll6uk2BwnwVbIriytb9lmyB6CmOKQUi7lDm2570Qklk=;
        b=QL27puZAXjKDk/LZEnH16YCapC6UFOTFIIWwW8Zs3gc/7b4eqc+do3vjzIxE0uyXEc
         pSek2mKGTyKemKBZoLUNR2G4MkeSE8fakJJH/ln+ywQ9T1DYkAz+e/4tVifo4RzV6l7v
         ZhuMI/IY4evHElCarz5OBkjMZnFCzgoqQI5xvtzXyd7nXStDrpwGOCIOlZPpk382eZdO
         RChK+yulkKSBqypDvn2RXh+QhDZFycwILg/cDhpaOpHhdgJLRQms72mjHPZGI1GuscL4
         Sa1ASWlzv24DCCu8F5okrZLP11JnT91WYBLZ3BSDY06Nq6J1EcsPstim4VUmyTjEo4je
         8s8g==
X-Forwarded-Encrypted: i=1; AJvYcCViJX5hdfXoXoc+tf6a6LElwy3uOs64E2Wap3jg/cJD2IugVOdNpnayzKNPSWj1EeIWUgaoh1OLQ2IMyLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JlX+96nvOoNBpQZEsdgBaFrDiJpnsrPk3s8b516+F3uSe2kp
	uxGCMxynaziYQ4WkMfOYsvAhE4slZwXLATRSYMqlh2Cgv0Tz8YHeacYEQk8+lQ==
X-Google-Smtp-Source: AGHT+IHO/t9dYiu6GbIiQglDQjpVGUD3F/yQGpyRTswXCu5Uzr8dEqi3rrJFgD/HOo7XJrCuHJ/7gg==
X-Received: by 2002:a17:902:cecb:b0:207:6d2:1aa5 with SMTP id d9443c01a7336-2074cb72a71mr866655ad.13.1725961063203;
        Tue, 10 Sep 2024 02:37:43 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ab54:b18d:dd53:2da1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e352c1sm45290365ad.65.2024.09.10.02.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:37:42 -0700 (PDT)
Date: Tue, 10 Sep 2024 18:37:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 0/3] zram: optimal post-processing target selection
Message-ID: <20240910093739.GD2413563@google.com>
References: <20240908114541.3025351-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908114541.3025351-1-senozhatsky@chromium.org>

On (24/09/08 20:45), Sergey Senozhatsky wrote:
> v2..v1:
> -- clear PP_SLOT when slot is accessed
> -- kmalloc pp_ctl instead of keeoing it on the stack
> -- increase the number of pp-buckets and rework the way it's defined
> -- code reshuffle and refactoring

Folks, ignore this series for now, I'm working on v3.

