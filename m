Return-Path: <linux-kernel+bounces-551905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8645A572CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E58D7A5D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8CE2561C7;
	Fri,  7 Mar 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CfSYRyIR"
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE902561BD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378283; cv=none; b=m9OLUNpg2C+ZVQILdLK/gKx5grV7IHQSeOcJeYStv+QejlFA8DvHYaFWgww5FBYsXXIS1k4Jl/pBady6XYl2kGwuAA7vyo6MkXOMT92zdTgLHjxePR01TNgkahkYdMXMQOnFak1CRdgeh7yDWObGqDl/R8pAznUQO56lJvgCf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378283; c=relaxed/simple;
	bh=XnokswpRVUawxvrh0+H2EO37FE3w3hGAjLgWW05bx5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9MmGjzJWeYgyg/Cpzjb5/qAWB0mHbz2A/R3xYF/KjvI13mOXGrTvCvlelZmggVXnUO6C+y3t31c9EJg+WtVxJUV+fL2k1g9ACGdjCJbApxpICaT4FxO+WS211nl2+rCAM7kQhLBNlWvKz+xdnjOvZnqIUJ0JDs2NEeQ9YsUsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CfSYRyIR; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so1961167276.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 12:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741378279; x=1741983079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XnokswpRVUawxvrh0+H2EO37FE3w3hGAjLgWW05bx5c=;
        b=CfSYRyIRM0jvy6C5rlcEtYOXSsnlv7OSvkQwANLjzG2JXhoMm29V4p54eVVBQaje+J
         fWjH37Oz3gCjbNIjGSRJDd58FFpgoTDu4qHV0L/RSIeIm5t50TJc7cj8na9T0Js1Wx/J
         WtGmHs0cgm5U8BMk1qViLwLSPXK3GwdvDgVDX3krXqKGT6Y0eP+Er1BZoBVCG6zajfT0
         IfFmQE8wEa5aBolFsh6lsZbzpq8YMdrRelsbbiCep5cpxj1AIOdCVkld3PupzTZ4EYnO
         in26eGJxEloLkalZNdVzOEeZtjcFo4jpIQbpDpfO3IE1KSw0IGC/rym+0ZZLVNwj9SPP
         /QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741378279; x=1741983079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnokswpRVUawxvrh0+H2EO37FE3w3hGAjLgWW05bx5c=;
        b=VBEILlS/3Ti6G9GSiviUuOAfPuXo0ZgqzhQ40+c8Y9guWHAGXcQQlxWBpytv48NmRj
         l1PgI0q7IDIIj7iu+5sU8bCUSlxlWhZhb3OaDH+Gp8AogxbzTtsgudeyPHEb9mbaTM0y
         /H81DEDDGW4e+87aXpYJ9S+2Bmc2oZ4CG8xzuHtXY9tT1M9RYKLQyf7RF2dD8+3/PwpZ
         50zVMsZdPuUMf3oMoguTWIGWgqejIekzO0Icx3KLN8n+kC0Ch19w/tWdf2+xv3VfEIXY
         4/RqNWeoapgvD8gngZ/YskdlFB1szjvmcO+F2Yu08o/+iRtWdv0l6oBjK95SgKdJiId9
         Qjxw==
X-Forwarded-Encrypted: i=1; AJvYcCWna8W/yEw9PEFEbZwscndgC0VUOB7naUnj8EryBDUGIjhaIbr8z8BGcE0eSYtBU+cC/qUrHIhuiuQ4Xmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUST2mNhiEklKMxFZI6xRDOKisXpQW86qr7RwEH3jYvAW7fI3
	t4jh+hznxSPDLaJ97hDFrTQgNjA3WHWIyl25EyECiYG3E74iiw7pE3ib3pRjnufgZuKkWUOz2zT
	kljJQr2zxspLEQIep6aYeqppag8Mb0r1F
X-Gm-Gg: ASbGncvtXdz7QlzV38r0WIEBFLMI3DHLrObE6QWw5OfRH0Onpivjd/Mjdr5yCsnOsvY
	jQdXvAuO7Nz+2/hr42xicfzfs0ktHSrkX7TGLjJ0qIu5Kwk5vZYwttGZ7w50vBNKqWKRzEk1Wsx
	peF52tYJgD55FYijCeMReVnZ/1paVJfMf3gRE2Z99m1zXL6i+yOXKLj8+aojMJJvIC/G86Yfn6x
	S9Yzr9f5gZ6msKwoOzwF2Uu8VvnEwaGpDtI3bk/Ra+2iyCQcaxP++UFUrHzCFAi3GJDLE5hk/WL
	IiyH2UNugKxRJbWDusT5A7iukUYHSz3+6rqsLUCK2GUiUTpMLA==
X-Google-Smtp-Source: AGHT+IFVIC1dPB2oQzuEy2i1L1p+CBm3CNBs2IFDf0LbWaFMmjn30sMZygpeRyebFOscyIQ6uTQhXSytdw3F
X-Received: by 2002:a05:6902:18c5:b0:e63:3e25:d71a with SMTP id 3f1490d57ef6-e636f7e8b1cmr1236822276.15.1741378279189;
        Fri, 07 Mar 2025 12:11:19 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e636dfd2009sm42439276.12.2025.03.07.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 12:11:19 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4B339340245;
	Fri,  7 Mar 2025 13:11:18 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3F0D3E56FE8; Fri,  7 Mar 2025 13:11:18 -0700 (MST)
Date: Fri, 7 Mar 2025 13:11:18 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Simon Horman <horms@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <Z8tS5t+warQdwFTs@dev-ushankar.dev.purestorage.com>
References: <20250220-netconsole-v5-0-4aeafa71debf@purestorage.com>
 <20250220-netconsole-v5-2-4aeafa71debf@purestorage.com>
 <20250225144035.GY1615191@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225144035.GY1615191@kernel.org>

On Tue, Feb 25, 2025 at 02:40:35PM +0000, Simon Horman wrote:
> Reviewed-by: Simon Horman <horms@kernel.org>

Hey, since this has gotten quiet for a while, just wanted to confirm
that there's no action needed from my end? Is this in the queue for
net-next?


