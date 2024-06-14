Return-Path: <linux-kernel+bounces-214918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F4908C14
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1431C2156D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BAD199EB1;
	Fri, 14 Jun 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SNE45HFG"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A468199249
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369611; cv=none; b=DH4+OZkL5GZ0b9EcJGSZPPOFDV3G+cVJYb1qUZj+Zy7e/fO+XQ5lI37Hyu/KqGD+Qh9ynSVGAIcDxlpQ5GQbYFekjdsTO3zOKFd0OTILaqXM+qgBbU/J9sX+vMWBAdYsPEnpu+BXI4FGDMCUs00vgsyWqCrTCerQPKo69PGcyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369611; c=relaxed/simple;
	bh=IjjAwUBZev5pXBrNN6OXYQrTj6ZG0bm1/jBwSbAoyHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/ojOLOFVRxk6AiseLyOwLJ2rm+UEq6OeWo0EKGBXYgsDdp+I3eYltTQBgtevkMHNRpY7Q40wGm4EPjwla0hFU7mVrr2LFTWQ5rPmD7DU0bwTNFY3vP+slH/iw+xOKsXLZG3aBVyfPMXkOamXn7sW+erpBPlNgRGsgqaE5coTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SNE45HFG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so2410421a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718369607; x=1718974407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoilSNR0Zv9v33itSh5XbUtg3+zoaXog3gNUXdNH/44=;
        b=SNE45HFGRFKTLxeyac+2VG6ox+Z2iRsCNgvbKlKORgyIT+H2jBEqHISNFfB2CQ5Jp+
         AJ8YotY9gj3zVSSFCR7hEjgWlLOSXmq4W++i6H6DWeeON1f6ZPGzdPc6Igvo/f2eyV6O
         P1TPiFPQJr9Gm8vniGiAThZ27xP2oM0gA6reJWZloEbGWBsVCnmIoyMuxP8dIQ0+zT9d
         WV3JFA44P3ILX18PYatA89btlMj4ifqseRnG5QmN9qVPP7OVxY1dpGvBvvOnQmjjRKfz
         KjmNhcN0oNzDuPTKrUevc53YzfI/6W2qW8TUNTd86r+ZQXUu9nmi/U/Fnz2KR8SGyy/B
         GWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718369607; x=1718974407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoilSNR0Zv9v33itSh5XbUtg3+zoaXog3gNUXdNH/44=;
        b=shNdEVzbSOJVVkSBDidBsLUlu1qarxA6sZn7jhNoEiQBkJEIpWwDVP1jKAuDqFCpYW
         ph7a5/s4YKZqL7wmZCM7ly1/EaQ9oTpawQS0xcxHcvCNqZmy5Y4kCagVLpPNG7leRe6R
         yRtK+9bxQcA6n9C8wML0Xl7PndXmVueQVViiohbV4X67kzJOJoXDvrdzrA7MFlip9dzF
         oX923DxozrI8Qa+56YyYKt8AIrs3RtQgvfAdq+/HtflL7RZ4Ehv4gpo/pijeb5L+GAru
         H7SExCbhgjyurdJBAYjyac3HQlBqFlZZM18K6luHRg0OG462H5lx8/Q9f5Pztph8KKJX
         mrqg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ScEyVI/KAdY2p573Wu/Y0YVTf6tEqpIP2xV918dqDEYc818he6J0bcA6wCMwMc4xYeBw53ZuOAYki3vVN7U/cyZn3Vi9/oIppaKL
X-Gm-Message-State: AOJu0Yz3+YZCd+/7SDUUcLyISK2xhuqRA4wgtPkJZars7BYXup2DNnFP
	oCQ7JFGDbIhgU0eqXgSSGyRjqwi/IpCEaJXEZQSDsSO8LjqQ/YH5twdW0NETJ5E=
X-Google-Smtp-Source: AGHT+IGUus8CsHftN39O9H3qVE2BWyF8K5O66Ib/Z5sLKQuE1yqYOfnw41+llGSpUsXUjxyHYw7cvQ==
X-Received: by 2002:a17:907:868d:b0:a6f:1285:4950 with SMTP id a640c23a62f3a-a6f60d20434mr184216566b.17.1718369606586;
        Fri, 14 Jun 2024 05:53:26 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f416dfsm182365366b.164.2024.06.14.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:53:26 -0700 (PDT)
Date: Fri, 14 Jun 2024 14:53:24 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ryan Sullivan <rysulliv@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, mpdesouza@suse.com,
	jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
	joe.lawrence@redhat.com, shuah@kernel.org
Subject: Re: [PATCH] selftests/livepatch: define max test-syscall processes
Message-ID: <Zmw9RFNjQjqIR4ro@pathway.suse.cz>
References: <alpine.LSU.2.21.2405311304250.8344@pobox.suse.cz>
 <20240606135348.4708-1-rysulliv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606135348.4708-1-rysulliv@redhat.com>

On Thu 2024-06-06 09:53:48, Ryan Sullivan wrote:
> Define a maximum allowable number of pids that can be livepatched in
> test-syscall.sh as with extremely large machines the output from a
> large number of processes overflows the dev/kmsg "expect" buffer in
> the "check_result" function and causes a false error.
> 
> Reported-by: CKI Project <cki-project@redhat.com>
> Signed-off-by: Ryan Sullivan <rysulliv@redhat.com>

JFYI, the patch has been committed into livepatching.git,
branch for-6.11.

Best Regards,
Petr

