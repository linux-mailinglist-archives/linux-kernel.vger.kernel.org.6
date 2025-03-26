Return-Path: <linux-kernel+bounces-577557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15504A71EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E8967A4990
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8E5253335;
	Wed, 26 Mar 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eLoz/+G3"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038218027
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015420; cv=none; b=OSvyE7JmsSAxc0mpEq6H8UEMXQnZ5YJik21+RyU5Di0MqdZGqEpq/bBkzwJoP+0u/o4s8+jg5L3tLE4GRMfaOiKWNUMAn7W/lqRxRNHRdVxz0hJBe8um5MLbtcPfGN1TnXflQ2OHNpZUidznOdOybkL4yL1i6ILItXJWCtt/ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015420; c=relaxed/simple;
	bh=jGpiZ3lPuBCyjBbQjqjfHfoJjy55SOzqxjPMosf7Ot8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEVfqFNFmSrnfGj/k+DStnsPPzQZKL5+dzoRNBUuAFOJEwsPdgxuLwX8emBuWdxx6YIMMpPSHcabxpLrsyihW/ECIDBHULoYY2n9PusEEPPlYBqOithja4+AU1ql1koLy2GmUfiBHLh0o+90oC3dMqg1npfImS7Oyqs9rj6nHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eLoz/+G3; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85b41281b50so7184139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743015417; x=1743620217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMSYNUtEXougJlHExQh8eBet5bvIJeI5uFDV0DD+oQ0=;
        b=eLoz/+G3BzzyNWtS6MMGQA9TZmjUWCr6TwBsq93oAoRAht4ZR9c1HzLyc0HyRtkfVG
         X8UYuaPODWt51YCJpAqb8W9p1jp0/v9wob52JL3qcnP9rQEua0asIpKPuyLwHPorzp/7
         Xsas89nirOm1+2L8cgDwX2oowCUW9kL4jB8ajkSjH/shOgFxGsAZdJ1mHMooe0xDMEOh
         Dnp8vMNPNZ0ZmGrTngsz/wOOi2yGbeBNKicRQeT+HMfl/uBz6Ao4b2QGCQ+cmVkAJqFR
         OnWNuSxfgoaIdZOy+vbi1I8tLN0xmZZ1eYa6CnHYJzKRFCENc5iCxF+wOh9kSR0SLnha
         +XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743015417; x=1743620217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMSYNUtEXougJlHExQh8eBet5bvIJeI5uFDV0DD+oQ0=;
        b=knH1Ic8eyEBYGWVoZKy/a4/eqgdwPEOybSOvQxptYBWvqrUS8fK3fjagEuHwI+nRA6
         P6IWzkNLYTwZ2IobOHgSceie0RwRUejbfQY72JIZzBv9uG9JytPMIyfriorqRigPfU/7
         NjoLvbmfSSbQTRk3AdMP6uCZEAZ3pZGfqTHTps53XO+e4LV0naHAam9QplFeteP04ZFV
         Vrwk+riuqNu6UhjdT1H1O/p+cVTLhc7jC9ZBhvwSYFSowe/Xu4b8moFQPBozGYNO3eVt
         3Z1r6n9sdqIJC0ovdbuD6DSLTEgLmi6q/HfcECYkAkPlwOFbuuJvBE62SFyVojgvZ9SI
         8KfA==
X-Forwarded-Encrypted: i=1; AJvYcCXIHRBc/nIj1sY+bukSmcBAi7iR6j7Ulwy0MhwOSqM8yb2cM4XbawLpApEEWg7Jh34p9KEVc0+4/OGRCLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKneb/KEOf4mguIBpgM36sBIJJE0Ptj3j2Yk0l7T6TC9Q2hsu
	2ftjAWICPDpKdSQLWg2q2pv/UrPhAUJ1a1PI2aDtXaomHeIWXfTodvxELPM23uJd0ns1LA44RM9
	mVguV/hFmXVEzeMXrPnVQdF+LYnvIbg0B
X-Gm-Gg: ASbGncvJu5mcELoLQIfuaqLieBFA/mFxSxFmpCnn6xWAHLNBtnMwA4Nx7xIZUl8D/7T
	C69uj6pX8Bz/WCnKvNnrUGdFnx2QVuKScXuBDc0jsZ2aMGNzUWxLwJICQDU81lL+lj9O3y9LLlL
	pQiBtDsmF9Z+ZuVWuO5AaRCNXzEDrW0Jq3lPOdVYTcGvcZC003nXBCxeEsxUg1FzocN2R6PXpnn
	y+LuMgbB5pZPTBoh08aku+QvVRuJ8Ac+PG0/Mc2Cl/JxClv6sY4AnCK+YwcunwEdxfSS4N3gSvK
	+xa/sqQ3FZy5c3ueI9QwiYjwux4DIK3m5qxwMNpbmDZnscFxyw==
X-Google-Smtp-Source: AGHT+IFprfUQX7hl7ALwRYy+fGTAFCgg2CZhgcsHAI4AVmaA2YLgu/KYeOGvdhWmwZaou7Txa0q9P1fZ+A3n
X-Received: by 2002:a05:6602:7286:b0:85b:3f1a:30aa with SMTP id ca18e2360f4ac-85e82127fb2mr121287439f.9.1743015417329;
        Wed, 26 Mar 2025 11:56:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f2cbf03468sm574746173.57.2025.03.26.11.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:56:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6300234024A;
	Wed, 26 Mar 2025 12:56:56 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 6BAF0E40158; Wed, 26 Mar 2025 12:56:56 -0600 (MDT)
Date: Wed, 26 Mar 2025 12:56:56 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z+RN+CPnWO69aJD5@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>

On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > ublk_abort_requests() should be called only in case of queue dying,
> > since ublk server may open & close the char device multiple times.
> 
> Sure that is technically possible, however is any real ublk server doing
> this? Seems like a strange thing to do, and seems reasonable for the
> driver to transition the device to the nosrv state (dead or recovery,
> depending on flags) when the char device is closed, since in this case,
> no one can be handling I/O anymore.

I see ublksrv itself is doing this :(

/* Wait until ublk device is setup by udev */
static void ublksrv_check_dev(const struct ublksrv_ctrl_dev_info *info)
{
	unsigned int max_time = 1000000, wait = 0;
	char buf[64];

	snprintf(buf, 64, "%s%d", "/dev/ublkc", info->dev_id);

	while (wait < max_time) {
		int fd = open(buf, O_RDWR);

		if (fd > 0) {
			close(fd);
			break;
		}

		usleep(100000);
		wait += 100000;
	}
}

This seems related to some failures in ublksrv tests


