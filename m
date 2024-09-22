Return-Path: <linux-kernel+bounces-335212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727197E29B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C75E1F218C7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B722B9C6;
	Sun, 22 Sep 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzJrNWrq"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18391CFB9;
	Sun, 22 Sep 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727024435; cv=none; b=uJkr9UWNtzHGk8Usc/qyyIxojj08ygZHlCnn5m9gfEArUIrTBfjTbymNsr9nD7fh77hwz84O+2TuG8voYS8K8FAP1w/XE3pv+hSMGrxLQLcgjXYgDc1konJXCly0GH6GKat6GuYWd1CBN/HCKS3M/gzlKaCtE5sBcq/+chqGw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727024435; c=relaxed/simple;
	bh=Xex4P2H5XpIBZGIjpjiNxh93l99KWf8IG8XW6ulLUDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HbIjFvs0kXHcjGEpXwpsSUCBu1bmiWtkDzgAV2upCJhNBYwQc1N/qQJESE482YhRIra3TJSyZnBPy4EhmqzSy908o7U97h7tVqc/FjPv0WhIBZipBPcf92cBBBXr/vKUvmaJUsGpTRkHGP6tiyHzAQglnV6rSCjZ8mCrCG0+u1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzJrNWrq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2068bee21d8so36003455ad.2;
        Sun, 22 Sep 2024 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727024433; x=1727629233; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGCNBFtzzfr7LREvT1rKgJ6X9oNvivfwjJCxXKomsyc=;
        b=ZzJrNWrqIBo65os5nLFbhUeve94cEps0fuCZCxULNyk/Bc3rTlB0Lb40TKx370zgAp
         1g1roSs9aUF7ujTDQAykf8vR8UdHdxtQoDIZoQZaG+g+ThhaDXgaQptkkPK4Mev5OSGp
         bWtYT+exYTWJhGrw9ZQoAqZCkyceQb/qZMrkJj5mjmwxpau7ULMI9yx7EdafCfpSRS4G
         5lXsB9epiVO+N8teWUVcqb/6Kd7K7RHBct06PXl5gsk+qNlyTMh+erWNaK0Sh7ElfzOq
         UAoI0Oyp31iTdDkD0OwuG5kmIysLrT8kEhreRYzmUnb2Drql2P80MuowwU0n5pFn2YQH
         BkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727024433; x=1727629233;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGCNBFtzzfr7LREvT1rKgJ6X9oNvivfwjJCxXKomsyc=;
        b=TYK0IRQGZeyv2VO/7t7guCJoRIqnRr+e43xEIOGZVpiWkb2Omho51hw0kJlqd5a5eK
         aJ66Mg+I6iV0prJ8r6k5hL9ZgF3hfcSpEHY/yrCEBqxpHzKKrmUDof5pRrUzQvbb5rv/
         AjIU5xLSmOXwV80NoFQXBxtouyAUbIGIORVsRC2z4pRFZ4BP6/dic2vW2Vc4FwQb/RZ/
         lAa1+Djoo/V9WNSeZjc2bMIP98EN9tBZ+A2KR2XkpwXttFr+7pNBXkilsJqrLgMUlHaz
         TMqvBk9WSFIKfJqc8Sfh7fg9owgC6Qc9xmdcK620kc4CPF0BnMFgvzf2KX33kKqWOA72
         N6WA==
X-Forwarded-Encrypted: i=1; AJvYcCVZbnMp52DIjOJzgjFO9SXYTWhiwzcVmtW+vq6DDCadEs/Yio1vORWEo95lhNAi8Fg4iSmXSxDLBd9F@vger.kernel.org, AJvYcCWFuKuB7fN8RotfA1AqL0GbCHLP+gOxs4MsWht7K6SWBCazP5caJihieKwDq1fV6+j+j0L8xfKD4tBiUDwv@vger.kernel.org, AJvYcCWLWNWV7BuWsQMIOjYg4s5aaDDHnRKyIbJMsxWl8l1ImBu/5KQYvQwsy+V0FPv7SieoyQjxQDQ1YSmX@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKx+nlcjCH+Dw0LZpG+blu7zLSNgfH0udOC1+pb/khEPx8g2B
	Vh3laFGqEVTTNYu3/rzd6A5+UaK5FZpjEVrbb6N3HygieMmthI3X/sw8PVA214M=
X-Google-Smtp-Source: AGHT+IGUPMaydTjShZ2+bQHHB0JQAQ2UoiJ14DkcjFrcCFXqcP6x5zDbhX1WN83T42b4uA0TTBpdgQ==
X-Received: by 2002:a17:903:2409:b0:206:ca91:1df8 with SMTP id d9443c01a7336-208d854ec49mr138635355ad.53.1727024432980;
        Sun, 22 Sep 2024 10:00:32 -0700 (PDT)
Received: from Emma ([2401:4900:1c94:b281:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fadsm122155475ad.70.2024.09.22.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 10:00:32 -0700 (PDT)
Date: Sun, 22 Sep 2024 17:00:29 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Roger Quadros <rogerq@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karan Sanghavi <karansanghvi98@gmail.com>
Subject: [PATCH] dt-bindings: usb: add missing compatible arraylist
Message-ID: <ZvBNLRc8xnAoGvoc@Emma>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Added the vice versa order for compatible property in the yaml file so
that the dtb can parse for the order mentioned in the dts file
k3-am642-sk.dts for ti,j721e-usb.yaml

This is highly ambiguous to me as where exactly the changes needs to be
added is it in the dts file or is the yaml where we have to reverse the
order already mentioned or do we have to add the another order as I have
done ?

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 95ff9791baea..822653217c43 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -17,6 +17,9 @@ properties:
       - items:
           - const: ti,j721e-usb
           - const: ti,am64-usb
+      - items:
+          - const: ti,am64-usb
+          - const: ti,j721e-usb
 
   reg:
     maxItems: 1
-- 
2.43.0


